function [A,B,C]=mp_rstochas(n,delta,k)
if nargin < 3
    mp.Digits(34);
else
    mp.Digits(k);
end

W=mp(rand(n));

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