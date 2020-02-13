clear;
c = 1;
for c1 = c
    ii = 0;
    s2 = [2:1:50000];
    for si = s2
        ii = ii + 1;
        clear x;
        x = -10000;
        sis = 1;
        p = c1*poly([sis si]);
        p1 = polyder(p);
        
        i = 0;
        ha = 0;
        while (i<100) && (abs(x(i+1) - sis) > 1e-8)
            i = i + 1;
            x(i+1) = x(i) - polyval(p,x(i))/polyval(p1,x(i));
            if (abs(x(i+1) - sis)/abs(x(i) - sis) < .005) && (ha == 0)
                B(c1,ii) = x(i+1);
                C(c1,ii) = x(i);
                ha = 1;
            end
        end
        if ha == 0
            B(c1,ii) = nan;
            C(c1,ii) = nan;
        end
        
%         dx = abs(1 - x);
%         dx_dx = dx(2:end)./dx(1:end-1);
%         dx_dx2 = dx(2:end)./dx(1:end-1).^2;
%     
%         s1 = subplot(1,3,1);
%         semilogy(abs(x - 1),'-o')
%         s2 = subplot(1,3,2);
%         plot(dx_dx,'-o')
%         s1.XLim(2) = s2.XLim(2);
%         s3 = subplot(1,3,3);
%         plot(dx_dx2,'-o')
%         s3.XLim(2) = s2.XLim(2);
%         pause(1)

    end    

end


subplot(1,1,1)
% [X,Y] = meshgrid(c,s2);
% surf(X,Y,B')
plot(s2,abs(C-sis),'ro-');hold on
plot(s2,abs(B-sis),'bo-');
[M,I] = max(abs(B-sis));
plot([1,2*(I+1)],[0,2*M],'-ok','LineWidth',4);hold off
ylim([0,(3/2)*max(abs(B-sis))])