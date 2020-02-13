function [value,i,j,t] = GSyl(A,B,C)
i = 1;
j = 1;
%X = C;
tic;
while i > 1e-16
    C1 = C + A*C*B;
    A = A*A;
    B = B*B;
    i = norm(C-C1);
    C = C1;
    j=j+1;
    
end
t = toc;
value = C;%i,j
end