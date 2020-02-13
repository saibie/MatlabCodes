function [A,B,C]=rabcs(n,delta)
W=((1-sqrt(delta))/(3*n - 3))*ones(n);
%W=ones(n);
I = eye(n);

for i=1:n
    W(i,i)=0;
    
end

A = W;
B = W - I;
%B = W - (delta+1)*(3*n - 3)*I;
C = W + sqrt(delta)*I;
end