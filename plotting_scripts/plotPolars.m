function h = plotPolars(freqs,data,h,fs,NFFT,c,fontsize,fontface,lsty)

wavwrite(data(1,1).IR,'temp');
y = wavread('temp');
Y1 = fft(y,NFFT)/length(y);
Y1 = 20*log10(2*abs(Y1(1:NFFT/2+1)));
f = fs/2*linspace(0,1,NFFT/2+1);

axesHandles = get(gcf,'children');


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
    
    
    if(numel(axesHandles) == length(freqs))
        axes(h(j));
        hold on;
    end
    
    h(j) = subplot(4,2,j);
    %hold on
    if(numel(axesHandles) == length(freqs))
        poo = mmpolar(h(j),theta,rho,...
            'Color',c,...
            'LineStyle',lsty,...
            'LineWidth',5,...
            'Style','compass',...
            'RLimit',[-26 8],...
            'RTickValue',[-20,-15,-10,-5,0,5],...
            'TLimit',[degtorad(-180) degtorad(180)],...
            'FontName',fontface,...
            'FontSize',fontsize);
    else
        poo = mmpolar(theta,rho,...
            'Color',c,...
            'LineStyle',lsty,...
            'LineWidth',5,...
            'Style','compass',...
            'RLimit',[-26 8],...
            'RTickValue',[-20,-15,-10,-5,0,5],...
            'TLimit',[degtorad(-180) degtorad(180)],...
            'RTickUnits','dB',...
            'FontName',fontface,...
            'FontSize',fontsize);
    end
    
    %set(poo,'LineWidth',2);
    xlabel([num2str(freqs(j)) ' Hz'],'FontSize',fontsize,'FontName',fontface);
    
    
    %legend(freqs(j));
    theta = [];
    rho = [];
    hold off;
end