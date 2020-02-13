function [A,B,C]=rstochas(n,delta)
I=eye(n);

%W = W - delta*I;
A = stoover3(n,delta);
B = stoover3(n,delta) - I;
C = stoover3(n,delta) + delta*I;
end

function S = stoover3(m,d)
S = rand(m);
for i=1:m
    S(i,i)=0;
end

s=sum(S,2);

for i=1:m
    S(i,:) = S(i,:)*(1-d)/s(i);
end
S = S / 3;
end