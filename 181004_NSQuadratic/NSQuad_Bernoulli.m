m = 80;
e = .5270437772535;
A = eye(m);
B = full(gallery('tridiag',m,-10,30,-10)); B(1,1) = 20; B(m,m) = 20;B = e*B;
C = full(gallery('tridiag',m,-5,15,-5));
tol = m*1e-15;
nomQ = zeros(100,1);

X0 = zeros(m);
tic
for i = 1:100
    QX0 = X0 + (A*X0 + B)\C;
    Q_X0 = eye(m^2) - kron(((A*X0+B)\C)',inv(X0 + A\B));
    h0 = - Q_X0 \ QX0(:);
    X1 = X0 + reshape(h0,m,m);
    X0 = X1;
    nomQ(i) = norm(X1 + (A*X1 + B)\C,'fro');
    if nomQ(i) < tol
        S = X1;
        break;
    end
end
t = toc
nomQ = nomQ(1:i);
semilogy(nomQ,'-o');