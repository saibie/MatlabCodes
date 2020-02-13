clear
a = 1;
b = -3;
c = 2;

i = 1;
x(i) = sym(-100);

tol = 1;
while tol > eps && i <= 1000
    x(i+1) = x(i) - (a*x(i)^2 + b*x(i) + c)./(2*a*x(i) + b);
    i = i + 1
    tol = a*x(i)^2 + b*x(i) + c;
    
end
s = x(i);

conv1 = (x(2:i)-s)./(x(1:i-1)-s);
conv2 = a.*x.^2 + b.*x + c;
f1x = - 2*a.*x - b;
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
