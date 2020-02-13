function Y = manyrroots(Z,p,q)
    x = linspace(-pi, pi, 1000);
    Z = Z/abs(Z);
    r1 = (Z^p)^(1/q);
    r2 = (Z^(1/q))^p;
    r3 = Z^(p/q);
    hold off
    plot(sin(x),cos(x),'k')
    title(['p = ',num2str(p),', q = ',num2str(q)])
    hold on
    plot([0 real(r1)],[0 imag(r1)],'r','LineWidth',4)
    plot([0 real(r2)],[0 imag(r2)],'g','LineWidth',3)
    plot([0 real(r3)],[0 imag(r3)],'k','LineWidth',2)
    axis equal
    axis([-1.5 1.5 -1.5 1.5])
    if abs(r2 - r3) < 1e-14
        k = 0;
    else
        k = 1;
    end
    Y = [r1 r2 r3 k];
end