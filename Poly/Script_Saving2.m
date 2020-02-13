clear

n = 6;
delta = 0.000000000;

tol = n * 1e-16;
dist = 1;
X0 = zeros(n);
I = eye(n);
P = [zeros(n/2),eye(n/2);eye(n/2),zeros(n/2)];

clear A;
K = rand(n/2);
for i=1:n/2;K(i,i)=0;end;
kk = sum(K,2);
for i=1:n/2
    K(i,:) = K(i,:)./kk(i);
end

W1 = ((1-delta)*K);%/(n-1))*(ones(n) - eye(n))
%W = rand(n);for i=1:n;W(i,i)=0;end;w=sum(W,2);for i=1:n;W(i,:)=W(i,:)/w(i);end
W1 = W1/3;

K = rand(n/2);
for i=1:n/2;K(i,i)=0;end;
kk = sum(K,2);
for i=1:n/2
    K(i,:) = K(i,:)./kk(i);
end

W2 = ((1-delta)*K);%/(n-1))*(ones(n) - eye(n))
%W = rand(n);for i=1:n;W(i,i)=0;end;w=sum(W,2);for i=1:n;W(i,:)=W(i,:)/w(i);end
W2 = W2/3;

C=[W1,zeros(n/2);zeros(n/2),W2];
B=[W1,zeros(n/2);zeros(n/2),W2]-eye(n);
A=[W1,zeros(n/2);zeros(n/2),W2];

% A = [1 0 ; 0 1];
% B = [-3 0 ; 0 -5];
% C = [2 0 ; 0 6];
% n=2;I = eye(2);P = [0 1 ; 1 0];X0 = zeros(2);tol = 1e-15;

%[S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4] = NM_Poly2019(A,zeros(n));

i = 1;
while (i < 100) && (dist > tol)
    P_X0{i} = kron(I, A*X0) + kron(X0',A) + kron(P',B*P');
    F = A*X0^2 + B*P'*X0*P + C;
    h = P_X0{i}\F(:);
    H{i} = reshape(h,n,n);
    X0 = X0 - H{i};
    XX{i} = X0;
    dist = norm(A*X0^2 + B*P'*X0*P + C,'fro');
    distv(i) = dist;
    i = i + 1;
end
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))
semilogy(distv,'ro-');
S = X0