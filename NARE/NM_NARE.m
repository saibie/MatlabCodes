function [S, XX, H, R_X0, DS, vR, RE, Conv, Conv2, Conv3, Conv4] = NM_NARE(C,D,A,B,X0,grph,minp,maxiter)

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


if nargin < 6
    grph = 1;
end

if nargin < 8                                                               % Auto Max Iteration
    maxiter = 100;
end

if nargin < 7                                                               % Auto Tolerance
    minp = n*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
In = eye(n);
Im = eye(m);
X{i} = X0;
pert = 1;
normA = norm(A,'fro');
normB = norm(B,'fro');
normC = norm(C,'fro');
normD = norm(D,'fro');


while (pert > minp) & (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    R_X0{i} = kron(In,X0*C) + kron(X0'*C',Im) - kron(D',Im) - kron(In,A);                      % R_X
    vR{i} = reshape((-(Nare(X0,C,D,A,B))),n*m,1);
    vH = R_X0{i} \ vR{i};
    H{i} = reshape(vH,m,n);
    X1 = X0 + H{i};
    X{i+1} = X1;
    if i == 1
        RE(i) = 0;
    else
        RE(i) = norm(X1,'fro')/norm(X0,'fro');                              % Relative Error
    end
    
    normX1 = norm(X1,'fro');
    pert = norm(Nare(X1,C,D,A,B),'fro')/(normC*normX1^2 + normD*normX1 + normA*normX1 + normB);
    %pert = norm(Qu(X1,A,B,C),'fro');
    %pert = norm(H{i},'fro')/norm(X1,'fro');
    
    i = i + 1;                                                              % Prepare for Next Iteration
    X0 = X1;
        
end

if i >= maxiter                                                             % The Iteration over the Max Iteration
    S = X1;
    XX = X;
    Conv = 0;
    Conv2 = 0;
    DS = 0;
    vQ = 0;
    RE = 0;
    Conv = 0;
    Conv2 = 0;
    for j=1:(maxiter - 2)
        Conv3(j) = norm((X{j+1} - S),'fro') / (norm((X{j+1}),'fro'));
    end
    for j=1:(maxiter - 2)
        Conv4(j) = norm(Nare(X{j+1},C,D,A,B),'fro');
    end
else                                                                        % Conver
    S = X1;
    DS = kron(In,S*C)+kron(S'*C',Im)-kron(D',Im)-kron(In,A);
    XX = X;
    for j=1:i-1
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
        Conv2(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        Conv3(j) = norm((X{j} - S),'fro') / (norm(S,'fro'));
        Conv4(j) = norm(Nare(X{j+1},C,D,A,B),'fro');
    end

    if grph == 1
        subplot(2,2,1)
        plot(Conv,'-o');hold on
        t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
        set(t1,'Interpreter','Latex');

        subplot(2,2,2)
        plot(Conv2,'-o');hold on
        t2 = title('${||\tilde{X_{i+1}}||}~ /~ {||\tilde{X_{i}||^2}}$');
        set(t2,'Interpreter','Latex');

        subplot(2,2,3)
        semilogy(Conv4,'-o');hold on
        t3 = title('log${||R(X_{i+1})||}$');
        set(t3,'Interpreter','Latex');

        subplot(2,2,4)
        semilogy(Conv3,'-o');hold on
        t4 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
        set(t4,'Interpreter','Latex');
    end
    
    
end

end