function pic(a,b,n)

x=(a:1/n:b);
[n1,n2]=size(x);
y=zeros(n2);
R1=zeros(n2);
R2=zeros(n2);

for i=1:n2
y(i)=myfunction(x(i));    
end

a=(-((log(2))/4)+1/4);
for i=1:n2
    R1(i)=x(i)/( (myfunction(x(i)/4)) * a);
end

for i=1:n2
    R2(i)=x(i)/( (myfunction(x(i)))/2 );
end


%plot(x,y)
hold off;
plot(x,1./R1,'r');hold on
plot(x,1./R2,'b')
