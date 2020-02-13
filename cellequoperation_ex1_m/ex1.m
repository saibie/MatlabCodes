function dx=orgi(t,x)
dx=zeros(2,1);

a = .3;
b = .2;
c = .5;
d = .2;
e = .5 * (mod(t,8) == 0);

dx(1)=a*x(1)-b*x(1)*x(2);
dx(2)=b*x(1)*x(2)-dx(2) - e;

