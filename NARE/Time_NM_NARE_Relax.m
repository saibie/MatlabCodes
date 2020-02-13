function [S, Time] = Time_NM_NARE_Relax(C,D,A,B,X0,minp,maxiter)

nA = size(A);
nB = size(B);
nC = size(C);
nD = size(D);
if nargin < 5
    X0 = zeros([nC(2) nC(1)]);
end
nX0 = size(X0);

if ~((nC(1)==nX0(2))&&(nC(2)==nX0(1))&&(nD(1)==nX0(2))&&(nD(2)==nX0(2))&&(nA(1)==nX0(1))&&(nA(2)==nX0(1))&&(nB(1)==nX0(1))&&(nB(2)==nX0(2)))                     % Are the size of matrices right?
    disp('The size of A,B,C,D and X0 are not right. (by NARE)');
    return
else
    m = nC(2);
    n = nC(1);
end



if nargin < 7                                                               % Auto Max Iteration
    maxiter = 100;
end

if nargin < 6                                                               % Auto Tolerance
    minp = n*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
In = eye(n);
Im = eye(m);
pert = 1;
normA = norm(A,'fro');
normB = norm(B,'fro');
normC = norm(C,'fro');
normD = norm(D,'fro');

tic;
while (pert > minp) && (i < maxiter)
    R_X0 = kron(In,X0*C) + kron(X0'*C',Im) - kron(D',Im) - kron(In,A);                      % R_X
    vR = reshape((-(Nare(X0,C,D,A,B))),n*m,1);
    vH = R_X0 \ vR;
    H = reshape(vH,m,n);
    X1 = X0 + H;
    alpha = min(min((Nare(X0,C,D,A,B) + Nare(X1,C,D,A,B))./(Nare(X0,C,D,A,B))));
    alpha = max(alpha, 1);
    X1 = X0 + alpha*H;
    
    normX1 = norm(X1,'fro');
    pert = norm(Nare(X1,C,D,A,B),'fro')/(normC*normX1^2 + normD*normX1 + normA*normX1 + normB);
    
    i = i + 1;                                                              % Prepare for Next Iteration
    X0 = X1;
        
end
Time = toc;
S = X1;

end