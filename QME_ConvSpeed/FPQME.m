function [S,i] = FPQME(A,B,C,X0,minp,maxiter)

nA = size(A);
nB = size(B);
nC = size(C);
if nargin < 4
    X0 = zeros(nA);
    nX0 = nA;
else
    nX0 = size(X0);
end


if ~((nA(1)==nA(2))&(nB(1)==nB(2))&(nC(1)==nC(2))&(nX0(1)==nX0(2)))         % Are they square matrices?
    disp('There is a non-square matrix in A, B, C and X0. (by QME)');
    return
elseif ~((nA(1)==nB(1))&(nB(1)==nC(1))&(nC(1)==nX0(1)))                     % Are the size of matrices same?
    disp('The size of A,B,C and X0 are not same. (by QME)');
    return
else
    n = nA(1);
end

if nargin < 7
    maxiter = 1000;
end

if nargin < 6
    minp = n*10^(-6);
    %minp = 10^(-16);
    %minp = 2^(-53);
    %minp = 0;
end

if nargin < 5
    offplot = 0;
end

%Initialize
i = 1;
I = eye(n);
pert = 1;
r = -min(diag(B));
N = B + r*I;

while (pert > minp) & (i < maxiter)
    X1 = inv(-B)*(A*X0^2 + C);
    
    pert = norm(Qu(X1,A,B,C),'fro');
    i = i + 1;
    X0 = X1;
        
end

if i >= maxiter
    fprintf('It doesn`t converges\n')
end

S = X1;
DS = (kron(S',inv(-B)*A)+kron(I,inv(-B)*A*S));

% subplot(2,2,1)
% plot(Conv,'-*')
% t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
% set(t1,'Interpreter','Latex');
% 
% subplot(2,2,2)
% plot(Conv2,'-');hold on;plot(length(Conv2),max(abs(eig(DS))),'*r');hold off
% t2 = title('$\sqrt[i]{{||\tilde{X_{i}}||}}$');
% set(t2,'Interpreter','Latex');
% 
% subplot(2,2,3)
% semilogy(Conv3,'-*')
% t3 = title('log${||Q(X_{i})||}$');
% set(t3,'Interpreter','Latex');
% 
% subplot(2,2,4)
% semilogy(Conv4,'-*')
% t4 = title('log$({||X_{i+1}-S||}~ /~ {||X_{i+1}||})$');
% set(t4,'Interpreter','Latex');
% 

end