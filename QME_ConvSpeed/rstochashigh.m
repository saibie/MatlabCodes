function [A,B,C]=rstochashigh(n,delta)
I=eye(n);
A = rand(n);
B = rand(n);
C = rand(n);

for i=1:n
    A(i,i)=0;
    B(i,i)=0;
    C(i,i)=0;
end

W = A + B + C;
w = sum(W,2);
A = diag(w)\A;
B = diag(w)\B;
C = diag(w)\C;

% A = A/(3*max(abs(eig(A))));
% B = B/(3*max(abs(eig(B))));
% C = C/(3*max(abs(eig(C))));

A = (1 - delta)*A;
B = (1 - delta)*B;
C = (1 - delta)*C;
%W = W - delta*I;
% A = A;
B = B - I;
C = C + delta*I;
end