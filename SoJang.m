clear
f = @SoJangF;
t0 = 0;
x0 = [-1;1];
h = .01;
tt = 55;
x = zeros(2, round((tt - t0)/h)); x(:,1) = x0;
t = zeros(1, round((tt - t0)/h)); t(1) = t0;

disp(sprintf('t\t\tx'));
disp(sprintf('--------------------------'));
for i = 2:length(t)
    t0 = t(i - 1);
    x0 = x(:, i - 1);
    k1 = h * f(t0,x0);
    k2 = h * f(t0 + h/2, x0 + k1/2);
    k3 = h * f(t0 + h/2, x0 + k2/2);
    k4 = h * f(t0 + h, x0 + k3);
    x1 = x0 + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    t1 = t0 + h;
    disp(sprintf('%.4f\t%.4f\t%.4f',t1,x1(1),x1(2)));
    t(i) = t1;
    x(:,i) = x1;
end

subplot(1,2,1);
plot(x(1,:), x(2,:), '-o');
subplot(1, 2, 2);
plot3(x(1,:), x(2,:), t, '-o');