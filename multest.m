function Y = multest(Z,p,q,s)
    Y = 0;
    if nargin < 4
        s = 0;
    end
    x = linspace(-pi, pi, 1000);
    Z = Z/abs(Z);
    for j=1:p-1
        r1 = (Z)^(j/q);
        r2 = Z^((p-j)/q);
        r3 = Z^(p/q);
        r4 = r1*r2;
        hold off
        plot(sin(x),cos(x),'k')
        title(['p1/q = ',num2str(j),'/',num2str(q),', p2/q = ',num2str(p-j),'/',num2str(q)])
        hold on
        plot([0 real(r1)],[0 imag(r1)],'b','LineWidth',1)
        plot([0 real(r2)],[0 imag(r2)],'g','LineWidth',1)
        plot([0 real(r3)],[0 imag(r3)],'k','LineWidth',3)
        plot([0 real(r4)],[0 imag(r4)],'r','LineWidth',2)
        axis equal
        axis([-1.5 1.5 -1.5 1.5])
        if abs(r4 - r3) < 1e-14
            k = 0;
        else
            k = 1;
        end
        if s ~= 0
            pause
        end
        Y = Y + k;
    end
        
end