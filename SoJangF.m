function y = SoJangF(t,x)
    x1 = x(1);
    x2 = x(2);
    y = [-x1 + exp(-2/3*t)*x2^2 ; -x2 + exp(1/2*t)*x1];
end