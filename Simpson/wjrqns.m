function y = wjrqns(v,alpha)
gamma = alpha/2 + pi/4;
y = cosh(v.*alpha).*tanh(v.*gamma)./sinh(v.*pi/2);
end