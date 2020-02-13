function [A S] = stoc_poly(m, n, delta)
A = zeros(m,m,n+1);
S = zeros(m);
for i=1:n+1
    A(:,:,i) = rand(m);
    for j=1:m
        A(j,j,i) = 0;
    end
end
S = sum(A,3);
vs = sum(S,2);

for i=1:n+1
    A(:,:,i) = diag(vs)\A(:,:,i);
end
S = sum(A,3);


r = max(abs(eig(S))) + delta;

A(:,:,2) = A(:,:,2) - r*eye(m);

end