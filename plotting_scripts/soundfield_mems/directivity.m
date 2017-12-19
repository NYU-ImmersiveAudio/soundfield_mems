close all;clear all; clc;

c = distinguishable_colors(25);
c = colormap('gray');
c = c.*15;
lsty = {'-','--','-','--'};
fs = 44100;

NFFT = 4096;
freqs = [500,1000,4000,8000,16000];
h = [];

measdists = {'ambio_2.mat'};

fontsize = 18;
fontface = 'times';

for i=1:length(measdists)
    load(measdists{i});
    h = plotPolars2(freqs,data,h,fs,NFFT,c(i,:),fontsize,fontface,lsty{i});
    
end

%# centimeters units
X = 12;                  %# A3 paper size
Y = 12;                  %# A3 paper size
xMargin = 1;               %# left/right margins from page borders
yMargin = 1;               %# bottom/top margins from page borders
xSize = X - 2*xMargin;     %# figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     %# figure size on paper (widht & hieght)

%# figure size displayed on screen (50% scaled, but same aspect ratio)
% set(gcf, 'Units','centimeters', 'Position',[0 0 xSize ySize]/2)
movegui(gcf, 'center')
h = legend('500','1000','4000','8000','16000');
v = get(h,'title');
set(v,'string','Frequency (Hz)');
set(v,'FontName',fontface);
set(v,'FontSize',fontsize);

fig=gcf;
set(findall(fig,'-property','FontName'),'FontName',fontface)

%# figure size printed on paper
% set(gcf, 'PaperUnits','centimeters')
% set(gcf, 'PaperSize',[X Y])
% set(gcf, 'PaperPosition',[xMargin yMargin xSize ySize])
% set(gcf, 'PaperOrientation','portrait')

% fontsize = 13;
% fontface = 'times';

set(gca,'FontName',fontface)
set(gca,'FontSize',fontsize)



print -depsc2 'azimuth.eps';
system(['open "azimuth.eps"']);