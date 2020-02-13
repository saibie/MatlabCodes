function dx=orgi(t,x)
dx=zeros(2,1);

a=3;
b=2;
d=2;
vm=5;

dx(1)=a*x(1)-b*x(1)*x(2);
dx(2)=b*x(1)*x(2)-d*x(2)-vm;

