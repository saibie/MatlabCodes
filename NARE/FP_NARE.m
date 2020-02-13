function [S, XX, DS, RE, Conv, Conv2, Conv3] = FP_NARE(C,D,A,B,X0,minp,maxiter,grph)

nA = size(A);
nB = size(B);
nC = size(C);
nD = size(D);
if nargin < 5
    X0 = zeros([nC(2) nC(1)]);
end
nX0 = size(X0);

if ~((nC(1)==nX0(2))&(nC(2)==nX0(1))&(nD(1)==nX0(2))&(nD(2)==nX0(2))&(nA(1)==nX0(1))&(nA(2)==nX0(1))&(nB(1)==nX0(1))&(nB(2)==nX0(2)))                     % Are the size of matrices right?
    disp('The size of A,B,C,D and X0 are not right. (by NARE)');
    return
else
    m = nC(2);
    n = nC(1);
end

if nargin < 7
    maxiter = 7000;
end

if nargin < 6
    minp = n*10^(-15);
    %minp = 10^(-16);
    %minp = 2^(-53);
    %minp = 0;
end

if nargin < 8
    grph = 1;
end

%Initialize
i = 1;
In = eye(n);
Im = eye(m);
X{i} = X0;
pert = 1;
rA = max(diag(A));
NA = rA*Im - A;
rD = max(diag(D));
ND = rD*In - D;

while (pert > minp) & (i < maxiter)
    X1 = (X0*C*X0 + NA*X0 + X0*ND + B)/(rA + rD);
    X{i+1} = X1;
    if i == 1
        RE(i) = 0;
    else
        RE(i) = norm(X1,'fro')/norm(X0,'fro');                                  % Relative Error
    end
    
    pert = norm(Nare(X1,C,D,A,B),'fro');
    i = i + 1;
    X0 = X1;
        
end

if i >= maxiter
    fprintf('It doesn`t converges\n')
end

S = X1;
DS = (kron(In,S*C) + kron(S'*C',Im) + kron(In,NA) + kron(ND',Im))/(rA + rD);
XX = X;
for j=1:i-1
    if norm((X{j}-S),'fro') == 0
        Conv(j) = 0;
    else
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
    end
    Conv2(j) = (norm((X{j} - S),'fro'))^(1/j);
    Conv3(j) = norm((Nare(X{j},C,D,A,B)),'fro');
    Conv4(j) = norm((X{j} - S),'fro');
end

if grph == 1
    subplot(2,2,1)
    plot(Conv,'-*')
    t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
    set(t1,'Interpreter','Latex');

    subplot(2,2,2)
    plot(Conv2,'-');hold on;plot(length(Conv2),max(abs(eig(DS))),'*r');hold off
    t2 = title('$\sqrt[i]{{||\tilde{X_{i}}||}}$');
    set(t2,'Interpreter','Latex');

    subplot(2,2,3)
    semilogy(Conv3,'-*')
    t3 = title('log${||R(X_{i})||}$');
    set(t3,'Interpreter','Latex');

    subplot(2,2,4)
    semilogy(Conv4,'-*')
    t4 = title('log$({||X_{i+1}-S||}~ /~ {||X_{i+1}||})$');
    set(t4,'Interpreter','Latex');
end

end