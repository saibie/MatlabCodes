clear
pa = [0 0 10];
a = poly(pa);

i = 1;
x(i) = -1000;

tol = 1;
while tol > eps && i <= 1000
    x(i+1) = x(i) - polyval(a,x(i))./polyval(polyder(a),x(i));
    i = i + 1;
    tol = abs(polyval(a,x(i)));
    
end
s = x(i);

conv1 = (x(2:i)-s)./(x(1:i-1)-s);
conv2 = abs(polyval(a,x));
f1x = abs(polyval(polyder(a),x));
f2x = abs(polyval(polyder(polyder(a)),x));
f1xoverf1x = f1x(2:i)./f1x(1:i-1);


subplot(2,3,1)
plot(conv1,'-o')
grid on
subplot(2,3,2)
semilogy(conv2,'-o')
grid on
subplot(2,3,4)
%semilogy(f1x,'-o')
plot(x,'-o')
grid on
subplot(2,3,5)
plot(f1xoverf1x,'-o')
grid on
subplot(2,3,6)
semilogy(f2x,'-o')
grid on

format longE
[x(2:i)',f1xoverf1x']
format short
