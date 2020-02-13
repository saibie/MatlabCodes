clear
tol = 1e-16;
maxiter = 100;
n = 8;

B = rand(n);
A = B*B';

i = 1;
reldiff = 100;
I = eye(n);
X0 = 100*eye(n);
while (reldiff > tol) & (i <= maxiter)
    DX0 = kron(I,X0) + kron(X0',I);
    vH = -DX0\reshape(X0^2 - A,n^2,1);
    X1 = X0 + reshape(vH,n,n);
    X1 = (X1 + X1')/2;
    reldiff = norm(X1^2 - A,'fro') / (norm(X1,'fro')^2*norm(A,'fro'));
    
    X0 = X1;
    i = i + 1;
    
end