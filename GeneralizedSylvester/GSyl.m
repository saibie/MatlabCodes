function [value,i,j,t] = GSyl(A,B,C)
i = 1;
j = 1;
%X = C;
tic;
a = min([max(abs(eig(A))), max(abs(eig(B)))])
while a^(2^(j-1)) > 1e-16
    C = C + A*C*B;
    A = A*A;
    B = B*B;
%     i = norm(A);
    j=j+1;
    
end
t = toc;
value = C;%i,j
end