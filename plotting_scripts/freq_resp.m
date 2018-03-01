close all;clear all;clc;

fs = 44100;
IRs = {'ambio_2', 'mems_2'};
c = distinguishable_colors(length(IRs));
%c = colormap('gray');
%c = c.*20;
%c = colormap(bone);
load ref;
wavwrite(data(1,1).IR,fs,'ref');

load ambio_2;
wavwrite(data(1,1).IR,fs,IRs{1});

load mems_2;
wavwrite(data(1,1).IR,fs,IRs{2});

N     = 64;    % Order
Fpass = 1;  % Passband Frequency
Apass = 0.0001;     % Passband Ripple (dB)
Astop = 100;    % Stopband Attenuation (dB)
% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.highpass('N,Fp,Ast,Ap', N, Fpass, Astop, Apass, fs);
Hd = design(h, 'ellip');

Fpass = 19500;  % Passband Frequency
Fstop = 20000;  % Stopband Frequency
Wpass = 1;      % Passband Weight
Wstop = 1;      % Stopband Weight
dens  = 20;     % Density Factor

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, [0 Fpass Fstop fs/2]/(fs/2), [1 1 0 0], [Wpass Wstop], ...
           {dens});
Hd_lo = dfilt.dffir(b);

x = wavread('ref.wav');
% x = x(93:end);

% x = filter(Hd_lo,x);

x = filter(Hd,x);
x = x./max(x);
smoothWin = 500;

NFFT = 4096*6;
f = fs/2*linspace(0,1,NFFT/2+1);

tmp = abs(f-1000);
[~, idx] = min(tmp);

Y1 = fft(x,NFFT)/length(x);
Y1 = 20*log10(2*abs(Y1(1:NFFT/2+1)));

for i=1:length(IRs)
    y = wavread(IRs{i});
%     y = y(93:end);
    y = filter(Hd,y);
    y = filter(Hd_lo,y);
    y = y./max(y);
    Y2 = fft(y,NFFT)/length(y);
    Y2 = 20*log10(2*abs(Y2(1:NFFT/2+1)));
    
    res = abs(Y1) + Y2;
    
    res = smooth(res,smoothWin);
    
    res = res - res(idx);
    
    %semilogx(f,res,'Color',c(i,:),'LineWidth',i/2);
    semilogx(f,res,'Color',c(i,:),'LineWidth',i);
    val = 2000; 
    tmp = abs(f-val);
    [d d] = min(tmp);
    %arrowline([0 0 0],[1000 1000 1000]);
    %text(val,res(d),IRs2{i},'FontSize',fontsize-5,'FontName',fontface);
    
    
    hold on
end

fontsize = 20;
fontface = 'times';

xlabel('Frequency (Hz)','FontSize',fontsize,'FontName',fontface);
ylabel('Relative response norm. at 1kHz (dB)','FontSize',fontsize,'FontName',fontface);
%legend('MEMs array','Panasonic electret');
xlim([20 20000]);

ylim([-20 20]);

set(gcf,'PaperPositionMode','auto')
set(gcf, 'Position', [0 0 1200 400])
set(gca, 'LooseInset', get(gca, 'TightInset'));

legend('Ambeo VR', 'MEMS' ,'Location','NorthWest');
%legend('MEMS microphone','Location','NorthWest');
grid on;
set(gca,'FontName',fontface)
set(gca,'FontSize',fontsize)
print -depsc2 freq_resp.eps;

print -depsc2 'freq_resp.eps';
system('open "freq_resp.eps"');
