close all;clear all; clc;
%delete('*.wav');
fs = 44100;
IRs = {'Panasonic-electret','MEMS-array','Blue-USB-condenser','Lapel-electret'};
c = distinguishable_colors(length(IRs));
%c = colormap('gray');
%c = c.*20;
%c = colormap(bone);
load ew;
wavwrite(data(1,1).IR,fs,'ewIR.wav');
load electret;
wavwrite(data(1,1).IR,fs,IRs{1});
load mems-array;
wavwrite(data(1,1).IR,fs,IRs{2});
load blue;
wavwrite(data(1,1).IR,fs,IRs{3});
load lapel;
wavwrite(data(1,1).IR,fs,IRs{4});

N     = 32;    % Order
Fpass = 60;  % Passband Frequency
Apass = 0.0001;     % Passband Ripple (dB)
Astop = 100;    % Stopband Attenuation (dB)
% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.highpass('N,Fp,Ast,Ap', N, Fpass, Astop, Apass, fs);
Hd = design(h, 'ellip');

x = wavread('ewIR.wav');
x = x(93:end);

x = filter(Hd,x);
x = x./max(x);
smoothWin = 300;

NFFT = 4096*6
f = fs/2*linspace(0,1,NFFT/2+1);

tmp = abs(f-1000);
[~, idx] = min(tmp);

Y1 = fft(x,NFFT)/length(x);
Y1 = 20*log10(2*abs(Y1(1:NFFT/2+1)));

fontsize = 20;
fontface = 'times';

IRs2 = {'Panasonic electret','MEMS','Blue USB condenser','Lapel electret'};
for i=1:length(IRs)
    y = wavread(IRs{i});
    y = y(93:end);
    y = filter(Hd,y);
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
ylabel('Relative response normalized at 1kHz (dB)','FontSize',fontsize,'FontName',fontface);
%legend('MEMs array','Panasonic electret');
xlim([60 20000]);

ylim([-25 25]);

set(gcf,'PaperPositionMode','auto')
set(gcf, 'Position', [0 0 1200 400])
set(gca, 'LooseInset', get(gca, 'TightInset'));

IRs = {'Panasonic electret','MEMS','Blue USB condenser','Lapel electret'};
legend(IRs,'Location','NorthWest');
%legend('MEMS microphone','Location','NorthWest');
grid on;
set(gca,'FontName',fontface)
set(gca,'FontSize',fontsize)
print -depsc2 all-mics-freq-resp.eps;

print -depsc2 '/Users/Charlie/Google Drive/Citygram/publications/AES2014 & Internoise/aes150_MEMS/all-mics-freq-resp.eps';
system(['open "/Users/Charlie/Google Drive/Citygram/publications/AES2014 & Internoise/aes150_MEMS/all-mics-freq-resp.eps"']);
