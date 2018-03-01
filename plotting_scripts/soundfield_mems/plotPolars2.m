function h = plotPolars2(freqs,data,h,fs,NFFT,c,fontsize,fontface,lsty)

c = distinguishable_colors(25);

wavwrite(data(1,1).IR,'temp');
y = wavread('temp');
Y1 = fft(y,NFFT)/length(y);
Y1 = 20*log10(2*abs(Y1(1:NFFT/2+1)));
f = fs/2*linspace(0,1,NFFT/2+1);

axesHandles = get(gcf,'children');

rhoArray = zeros(length(freqs), (length(data) * 2) - 1);

size(rhoArray)

for j=1:length(freqs)
    tmp = abs(f-freqs(j));
    [~, idx] = min(tmp);
    
    
    theta(1) = 0;
    rho(1) = 0;
    
    for i=2:length(data)
        wavwrite(data(1,i).IR,'temp');
        y = wavread('temp');
        
        Y2 = fft(y,NFFT)/length(y);
        Y2 = 20*log10(2*abs(Y2(1:NFFT/2+1)));
        
        diff =  Y2(idx) - Y1(idx);
        
        theta(i) = degtorad(data(1,i).azimuth) + degtorad(data(1,i).elevation);
        rho(i) = diff;
    end
    
    theta = [ -fliplr(theta) theta(2:end)];
    rho = [fliplr(rho) rho(2:end)];
    
    mmpolar(theta,rho,...
            'Color',c(j,:),...
            'LineWidth',10,...
            'Style','compass',...
            'RLimit',[-15 2],...
            'RTickValue',[-20,-15,-10,-5,0,5],...
            'TLimit',[degtorad(-180) degtorad(180)],...
            'FontName',fontface,...
            'TTickValue',[0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330],...
            'TTickOffset', 0.1,...
            'FontSize',fontsize);
    
    hold on;
    
    rhoArray(j,:) = rho;
    thetaArray(j,:) = theta;
    rho = [];
    theta = [];
end

% mmpolar(theta,rho,...
%             'Color',c,...
%             'LineStyle',lsty,...
%             'LineWidth',5,...
%             'Style','compass',...
%             'RLimit',[-30 20],...
%             'RTickValue',[-20,-15,-10,-5,0,5],...
%             'TLimit',[degtorad(-180) degtorad(180)],...
%             'FontName',fontface,...
%             'FontSize',fontsize);
%     hold on;

        
% xlabel([num2str(freqs(j)) ' Hz'],'FontSize',fontsize,'FontName',fontface);