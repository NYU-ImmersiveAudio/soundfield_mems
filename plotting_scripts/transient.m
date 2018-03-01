close all;clear all; clc;
c = distinguishable_colors(25);
fs = 44100;

x(1,:) = wavread('transient/dpa.wav',fs);
x(2,:) = wavread('transient/mems.wav',fs);
x(3,:) = wavread('transient/mems-array.wav',fs);
x(4,:) = wavread('transient/panasonic.wav',fs);
x(5,:) = wavread('transient/polson.wav',fs);
x(6,:) = wavread('transient/blue.wav',fs);


[~,idx1] = max(x(5,:));
[~,idx2] = max(x(6,:));

x(6,:) = [x(6,idx2-idx1:end) x(6,2:idx2-idx1)];

titles = {'DPA condenser','MEMS single','MEMS array','Panasonic electret','Polson electret','Blue USB condenser'};


for i=1:6
    subplot(6,1,i);
    
    [~,idx] = max(x(i,:));
    
    xx(i,:) = x(i,idx-100:idx+400);
    
    plot(xx(i,:),'Color',c(i,:));
    title(titles{i},'Color',c(i,:));
    ylim([-0.6 0.6]);
    xlim([0 500]);
    ylabel('Amplitude');
    grid on;
end

xlabel('Samples @ fs=44.1kHz');

%# centimeters units
X = 42.0;                  %# A3 paper size
Y = 29.7;                  %# A3 paper size
xMargin = 1;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)

%# figure size displayed on screen (50% scaled, but same aspect ratio)
set(gcf, 'Units','centimeters', 'Position',[0 0 xSize ySize]/2)
movegui(gcf, 'center')

%# figure size printed on paper
set(gcf, 'PaperUnits','centimeters')
set(gcf, 'PaperSize',[X Y])
set(gcf, 'PaperPosition',[xMargin yMargin xSize ySize])
set(gcf, 'PaperOrientation','portrait')

print -depsc2 transient-response.eps;