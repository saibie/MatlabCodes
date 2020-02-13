clear
m = 5;
delta = 0.1;
A = rabcs(m,delta);
[S, Xs, Ys, i, time] = NewtonPoly(A);
N = .1*ones(m);
I = eye(m);


for l=1:m-1
    P1(l,l)=-1;
    P1(l+1,l)=1;
end
P = ones(m,1);
P = [P P1];
D = min(roots([1-delta -2-delta 1+2*delta]));
for l=2:m
    D(l,l) = max(roots([(-(1-delta)/(3*(m-1))) (-(1-delta)/(3*(m-1)))-1 (-(1-delta)/(3*(m-1)))+delta]));
end
S1 = P*D*inv(P);
S1s = [];
for l=1:i
    S1s = cat(3,S1s,S1);
end

tXs = Xs - S1s;
ntXs = zeros(l,1);
nPXs = zeros(l,1);
tYs = Ys - S1s;
ntYs = zeros(l,1);
nPYs = zeros(l,1);
for l=1:i
    ntXs(l) = norm(tXs(:,:,l),'fro');
    ntYs(l) = norm(tYs(:,:,l),'fro');
    nPXs(l) = norm(Polynom(Xs(:,:,l),A),'fro');
    nPYs(l) = norm(Polynom(Ys(:,:,l),A),'fro');
end

P_S = kron(I,A(:,:,2)) + kron(S1',A(:,:,3)) + kron(I,A(:,:,3)*S1);

[X D] = eig(P_S);
iX = inv(X);norm(imag(iX),'fro')
Pn = real(X(:,1)*iX(1,:));
Pm = real(X(:,2:m^2)*iX(2:m^2,:));
Pns = nan(m,m,i);
Pms = nan(m,m,i);
nPns = nan(i,1);
nPms = nan(i,1);
for l=1:i
    K = tXs(:,:,l);
    coeff = X\K(:);
    Pns(:,:,l) = reshape(X(:,1)*coeff(1),m,m);
    Pms(:,:,l) = reshape(X(:,2:end)*coeff(2:end),m,m);
    nPns(l) = norm(Pns(:,:,l),'fro');
    nPms(l) = norm(Pms(:,:,l),'fro');
end

for l=1:i
    x(l) = norm(S1 - Xs(:,:,l),'fro');
end