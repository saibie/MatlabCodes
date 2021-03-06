clear
alpha = [-pi/3 -pi/4 -pi/6 0 pi/6 pi/4 pi/3];
for i=1:7
    gamma(i) = alpha(i)/2 + pi/4;
    Itg(i) = quad(@(v)wjrqns(v,alpha(i)),0,500);
    I(i) = cos(alpha(i))*Itg(i);
    f500(i) = wjrqns(500,alpha(i));
end

disp(sprintf('alpha : %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f',alpha))
disp(sprintf('==================================================================================================================='))
disp(sprintf('gamma : %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f',gamma))
disp(sprintf('==================================================================================================================='))
disp(sprintf('I     : %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f',I))
disp(sprintf('==================================================================================================================='))
disp(sprintf('f(500): %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f   %0.6f',f500))
