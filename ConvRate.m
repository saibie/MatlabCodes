function [x, x_rate, xd_rate, fp_rate, all_rate, fp] = ConvRate(x0, p, s)
    close all

    x = nan(10000,1);
    x_rate = nan(9999,1);
    xd_rate = nan(9998,1);
    fp_rate = nan(9999,1);
    all_rate = nan(9999,1);
    fp = nan(10000,1);
    
    x(1) = x0;
    pp = [length(p)-1:-1:1].*p(1:length(p)-1);
    
    for i=1:9999
        x(i+1) = x(i) - polyval(p,x(i))/polyval(pp,x(i));
        x_rate(i) = abs(x(i+1) - s)/abs(x(i) - s);
        if i~=1; xd_rate(i-1) = abs(x(i+1) - x(i))/abs(x(i) - x(i-1)); end;
        fp_rate(i) = polyval(pp,x(i+1))/polyval(pp,x(i));
        all_rate(i) = (polyval(p,x(i+1))*polyval(pp,x(i)))/(polyval(p,x(i))*polyval(pp,x(i+1)));
        fp(i) = polyval(pp,x(i));
    end
    fp(10000) = polyval(pp,x(10000));
    
    f1 = figure(1);
    f1.Position = [100 100 1000 500];
    ax1 = axes('Units','pixel',...
        'Position', [50 50 600 400]);
    pl1 = plot(ax1,x,'-o');
    b11 = uicontrol('Parent',f1,'Style','slider','Position',[700,350,275,25],'value',ax1.XLim(2), 'min',1, 'max',10000, 'Callback', @uc11, 'SliderStep',[0.0001 .1]);
    b12 = uicontrol('Parent',f1,'Style','slider','Position',[700,275,275,25],'value',max(abs(ax1.YLim)), 'min',.1, 'max',max(max(abs(ax1.YLim)),10), 'Callback', @uc12);
    b13 = uicontrol('Parent',f1,'Style','Popup','String',{'x', 'x_rate', 'xd_rate', 'fp_rate', 'all_rate', 'fp'},'Position',[700 425 175 25], 'Callback', @uc13);
    uicontrol('Style','text','Position',[700 375 275 25],'String','X-axis Limit');
    uicontrol('Style','text','Position',[700 300 275 25],'String','Y-axis Limit');
    

    
    function uc11(source,callbackdata)
        val = source.Value;
        xlim(ax1,[.9 val]);
    end

    function uc12(source,callbackdata)
        val = source.Value;
        ylim(ax1,[-val val]);
    end


    
    function uc13(source,callbackdata)
        val = source.Value;
        gra = source.String;
        v = gra{val};
        
        switch v
            case 'x'
                pl1 = plot(ax1,x,'-o');
            case 'x_rate'
                pl1 = plot(ax1,x_rate,'-o');
            case 'xd_rate'
                pl1 = plot(ax1,xd_rate,'-o');
            case 'fp_rate'
                pl1 = plot(ax1,fp_rate,'-o');
            case 'all_rate'
                pl1 = plot(ax1,all_rate,'-o');
            case 'fp'
                pl1 = plot(ax1,fp,'-o');
        end
        
        b11.Value = ax1.XLim(2);
        b12.Max = max(max(abs(ax1.YLim)),10);
        b12.Value = max(abs(ax1.YLim));
    end
    
end