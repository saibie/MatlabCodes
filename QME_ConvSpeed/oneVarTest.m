clear f f1 f2 x y

f = poly([1 7]);
f1 = polyder(f);
f2 = polyder(f1);
x = [-10:.001:10];
y = x - polyval(f,x)./polyval(f1,x);
plot(x,y,[1 1],[-10 10],[-10 10],[1 1],[-10 10],[-10 10]);%,mean(roots(f))*ones(2,1),[-10 10],[-10 10],[-5+mean(roots(f))/2 5+mean(roots(f))/2]);
axis([-10 10 -10 10]);
axis equal