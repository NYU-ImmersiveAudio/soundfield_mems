close all;clear all; clc;
c = distinguishable_colors(25);
fs = 44100;

levels = [37.3,57.8,80.1,87.2,90.9,93.5,95.5,96.9,97.2,97.4,97.7,97.9,97.9];
titles = {'XL2','MEMS single','MEMS array','Panasonic electret','Polson electret','Blue USB condenser'};

extime = 8;



x(1,:) = wavread('dynamic/slm44.wav',fs*extime);
x(2,:) = wavread('dynamic/mems.wav',fs*extime);
x(3,:) = wavread('dynamic/mems-array.wav',fs*extime);
x(4,:) = wavread('dynamic/panasonic.wav',fs*extime);
x(5,:) = wavread('dynamic/polson.wav',fs*extime);
x(6,:) = wavread('dynamic/blue.wav',fs*extime);

for i=1:6
    sens = max(x(i,1:2000));
    sensdb = 20*log10(sens)
end

x = 20*log10(abs(x));
x(~isfinite(x)) = -90;
%x = smooth(x,100);

t = (0:1/fs:length(x)/fs);
t = t(1:end-1);
for i=1:6
    %subplot(6,1,i);
    
    %envelope = abs(hilbert(x(i,:)));
    
    figure(i)
    %plot(t,x(i,:),'Color',c(i,:));
    %hold on
    envelope = smooth(x(i,:),1000) + 15;
    
    tmp = abs(envelope-94);
    [~, idx] = min(tmp);
    sensitivity = envelope(idx);
    
    mnHi = mean(envelope(end-fs:end));
    -mnHi+98;
    df = 98 - mnHi;
    
    mnLo = mean(envelope(100:fs/2));
    
    maxSPL = -mnHi+98
    
    envelope = envelope + df;
    plot(t,envelope,'-k');
    title(titles{i});
    ylim([30 -mnHi+98]);
    xlim([0 6.5]);
    ylabel('Amplitude');
    grid on;
end