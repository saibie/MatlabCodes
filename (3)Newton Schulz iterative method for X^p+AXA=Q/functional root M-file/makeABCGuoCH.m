% make A,B,C for over-damped problem 1
function [A, B, C]=makeABCGuoCH(m,a,b);

A = eye(m);
B = zeros(m);
C = -eye(m);
n=m/2;
for i=1:n;
    B(i,i)=a;
end
for i=n+1:m;
    B(i,i)=b;
end
for i = 1:m-1;
    C(i,i+1) = 1;
end
C(m,1)=1;