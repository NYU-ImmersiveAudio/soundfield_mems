close all;clear all; clc;
%delete('*.wav');
c = distinguishable_colors(25);
fs = 44100;

NFFT = 4096;
freqs = [125,250,500,1000,2000,4000,8000,16000];
h = [];

measdists = {'data/test1.mat'};

for i=1:length(measdists)
    load(measdists{i});
    data = [data(1,1) data(8:end)];
    
    h = plotPolars(freqs,data,h,fs,NFFT,c(i,:));
end

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

print -depsc2 mems-polar-elevation.eps;