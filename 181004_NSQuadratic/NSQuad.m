m = 8;
e = .5270437772535;
A = eye(m);
B = full(gallery('tridiag',m,-10,30,-10)); B(1,1) = 20; B(m,m) = 20;B = e*B;
C = full(gallery('tridiag',m,-5,15,-5));
tol = m*1e-15;
nomQ = zeros(100,1);

X0 = zeros(m);
for i = 1:100
    QX0 = A*X0^2 + B*X0 + C;
    Q_X0 = kron(X0',A) + kron(eye(m),A*X0 + B);
    h0 = - Q_X0 \ QX0(:);
    X1 = X0 + reshape(h0,m,m);
    X0 = X1;
    nomQ(i) = norm(A*X1^2 + B*X1 + C,'fro');
    if nomQ(i) < tol
        S = X1;
        break;
    end
end
nomQ = nomQ(1:i);
semilogy(nomQ,'-o');