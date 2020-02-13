clear A B C D X nomR
X = nan(3,5,101);
delta = 0;
tol = 1e-15;
X0 = zeros(3,5);X(:,:,1) = X0;

WA = rand(3);
for ii=1:3;WA(ii,ii) = 0;end
WA = diag(sum(WA,2))\WA;
A = eye(3) - (1 - delta)*(3/4)*WA;

WB = rand(3,5);
WB = diag(sum(WB,2))\WB;
B = (1 + delta/3)*(1/4)*WB;

WC = rand(5,3);
WC = diag(sum(WC,2))\WC;
C = (1 - delta)*(1/4)*WC;

WD = rand(5);
for ii=1:5;WD(ii,ii) = 0;end
WD = diag(sum(WD,2))\WD;
D = eye(5) - (1 + delta/3)*(3/4)*WD;

nomA = norm(A,'fro');nomB = norm(B,'fro');nomC = norm(C,'fro');nomD = norm(D,'fro');

for i=1:100
    Rx = kron(eye(5),X0*C - A) + kron((C*X0 - D).',eye(3));
    RX = Ricca(X0,A,B,C,D);
    h = -Rx\RX(:);
    H = reshape(h,3,5);
    X1 = X0 + H;X(:,:,i+1) = X1;X0 = X1;
    nomX1 = norm(X1,'fro');
    if norm(Ricca(X1,A,B,C,D),'fro')./(nomC*nomX1^2 + nomD*nomX1 + nomA*nomX1 + nomB) < tol;
        S = X1;
        break;
    end
end
X = X(:,:,1:i+1);
nomR = zeros(i+1,1);
for ii=1:i+1
    nomR(ii) = norm(Ricca(X(:,:,ii),A,B,C,D),'fro');
end