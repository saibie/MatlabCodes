clear
a = 1;
b = -5;
c = 9;
d = -7;
e = 2;

i = 1;
x(i) = -1000;

tol = 1;
while tol > eps && i <= 1000
    x(i+1) = x(i) - (a*x(i)^4 + b*x(i)^3 + c*x(i)^2 + d*x(i) + e)./(4*a*x(i)^3 + 3*b*x(i)^2 + 2*c*x(i) + d);
    i = i + 1
    tol = abs(a*x(i)^4 + b*x(i)^3 + c*x(i)^2 + d*x(i) + e);
    
end
s = x(i);

conv1 = (x(2:i)-s)./(x(1:i-1)-s);
conv2 = abs(a*x.^4 + b*x.^3 + c*x.^2 + d*x + e);
f1x = -(4*a*x.^3 + 3*b*x.^2 + 2*c*x + d);
f1xoverf1x = f1x(2:i)./f1x(1:i-1);


subplot(2,2,1)
plot(conv1,'-o')
grid on
subplot(2,2,2)
semilogy(conv2,'-o')
grid on
subplot(2,2,3)
semilogy(f1x,'-o')
grid on
subplot(2,2,4)
plot(f1xoverf1x,'-o')
grid on
