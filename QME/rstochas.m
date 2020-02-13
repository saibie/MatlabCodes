function [A,B,C]=rstochas(n,delta)
W=rand(n);

for i=1:n
    W(i,i)=0;
end

w=sum(W,2);
I=eye(n);
for i=1:n
    W(i,:)=W(i,:)*(1-delta)/w(i);
end
%W = W - delta*I;
W = W / 3;
A = W;
B = W - I;
C = W + delta*I;
end