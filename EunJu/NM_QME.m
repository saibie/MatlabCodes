function [S, XX, H, D_X0, DS, vQ, RE, Conv, Conv2, Conv3, Conv4] = NM_QME(A,B,C,X0,minp,maxiter)

nA = size(A);
nB = size(B);
nC = size(C);
if nargin < 4
    X0 = zeros(nA);                         % Auto Initial Value
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

if nargin < 6                                                               % Auto Max Iteration
    maxiter = 100;
end

if nargin < 5                                                               % Auto Tolerance
    minp = n*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
I = eye(n);
X{i} = X0;
pert = 1;
normA = norm(A,'fro');
normB = norm(A,'fro');
normC = norm(A,'fro');


while (pert > minp) & (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    D_X0{i} = kron(X0',A) + kron(I, A*X0) + kron(I,B);                      % D_X
    vQ{i} = reshape((-(Qu(X0,A,B,C))),n^2,1);
    vH = D_X0{i} \ vQ{i};
    H{i} = reshape(vH,n,n);
    X1 = X0 + H{i};
    X{i+1} = X1;
    if i == 1
        RE(i) = 0;
    else
        RE(i) = norm(X1,'fro')/norm(X0,'fro');                              % Relative Error
    end
    
    normX1 = norm(X1,'fro');
    pert = norm(Qu(X1,A,B,C),'fro')/(normA*normX1^2 + normB*normX1 + normC);
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
        Conv4(j) = norm(Qu(X{j+1},A,B,C),'fro');
    end
else                                                                        % Conver
    S = X1;
    DS = kron(S',A)+kron(I,A*S)+kron(I,B);
    XX = X;
    for j=1:i-1
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
        Conv2(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        Conv3(j) = norm((X{j} - S),'fro') / (norm(S,'fro'));
        Conv4(j) = norm(Qu(X{j+1},A,B,C),'fro');
        Conv5(j) = max(reshape(X{j+1} - X{j},n^2,1));
        Conv6(j) = min(reshape(X{j+1} - X{j},n^2,1));
        Conv7(j) = max(reshape(X{j+1} - X{j},n^2,1))/max(reshape(X{j+1},n^2,1));
        Conv8(j) = min(reshape(X{j+1} - X{j},n^2,1));
        
    end
    
    figure(1);
    subplot(2,2,1)
    plot(Conv,'-o')
    t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
    set(t1,'Interpreter','Latex');

    subplot(2,2,2)
    plot(Conv2,'-o')
    t2 = title('${||\tilde{X_{i+1}}||}~ /~ {||\tilde{X_{i}||^2}}$');
    set(t2,'Interpreter','Latex');

    subplot(2,2,3)
    semilogy(Conv4,'-o')
    t3 = title('log${||Q(X_{i+1})||}$');
    set(t3,'Interpreter','Latex');

    subplot(2,2,4)
    semilogy(Conv3,'-o')
    t4 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
    set(t4,'Interpreter','Latex');
    
    figure(2);
    subplot(2,2,1)
    semilogy(Conv5,'-o')
    t5 = title('${\mathrm{max}(X_{i+1} - X_{i})}$');
    set(t5,'Interpreter','Latex');

    subplot(2,2,2)
    semilogy(Conv6,'-o')
    t6 = title('${\mathrm{min}(X_{i+1} - X_{i})}$');
    set(t6,'Interpreter','Latex');

    subplot(2,2,3)
    semilogy(Conv7,'-o')
    t7 = title('${\mathrm{max}(X_{i+1} - X_{i})} / \mathrm{max}(X_{i+1})$');
    set(t7,'Interpreter','Latex');

    subplot(2,2,4)
    plot(Conv8,'-o')
    t4 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
    set(t4,'Interpreter','Latex');
    
    
end

end