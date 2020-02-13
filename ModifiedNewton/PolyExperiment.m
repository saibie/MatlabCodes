clear;
m = 5;
delta = 0.1;
W = ones(m)./(m-1);
for i=1:m
    W(i,i)=0;
end
W = ((1-delta)*W);

A(:,:,1)=4096.*W;
A(:,:,2)=56.*W-6200.*eye(m);
A(:,:,3)=384.*W;
A(:,:,4)=1312.*W;
A(:,:,5)=321.*W;
A(:,:,6)=30.*W;
A(:,:,7)=W+6200*delta*eye(m);

A = A./6200;

[S, Xs, Ys, i, time] = NewtonPoly(A);
N = .2*ones(m);
I = eye(m);

for l=1:m-1
    P1(l,l)=-1;
    P1(l+1,l)=1;
end
P = ones(m,1);
P = [P P1];
D = min(roots([(1-delta)+6200*delta,30*(1-delta),321*(1-delta),1312*(1-delta),384*(1-delta),56*(1-delta)-6200,4096*(1-delta)]));
for l=2:m
    D(l,l) = min(roots([(1-delta)-6200*(m-1)*delta,30*(1-delta),321*(1-delta),1312*(1-delta),384*(1-delta),56*(1-delta)+6200*(m-1),4096*(1-delta)]));
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

P_S = zeros(m^2);
for j=1:6                                                               % P_X
    for k=1:j
        P_S = P_S + kron(S1'^(j-k),A(:,:,j+1)*S1^(k-1));
    end
end

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