function [S, XX, H, D_X0, DS, Conv, Conv2, Conv3, Conv4] = Posqrt(A,X0,minp,maxiter)

nA = size(A);
if nargin < 2
    X0 = A^2;                         % Auto Initial Value
    nX0 = nA;
else
    nX0 = size(X0);
end


if ~((nA(1)==nA(2))&(nX0(1)==nX0(2)))         % Are they square matrices?
    disp('There is a non-square matrix in A and X0. (by SQRT)');
    return
elseif ~((nA(1)==nX0(1)))                     % Are the size of matrices same?
    disp('The size of A and X0 are not same. (by SQRT)');
    return
else
    n = nA(1);
end

if nargin < 4                                                               % Auto Max Iteration
    maxiter = 100;
end

if nargin < 3                                                               % Auto Tolerance
    minp = n*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
I = eye(n);
X{i} = X0;
pert = 1;
normA = norm(A,'fro');


while (pert > minp) & (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    D_X0{i} = kron(X0',I) + kron(I, X0);                      % D_X
    vQ{i} = reshape((-(X0^2 - A)),n^2,1);
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
    pert = norm(X1^2 - A,'fro')/(normX1^2 + normA);
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
        Conv4(j) = norm(X{j+1}^2 - A,'fro');
    end
else                                                                        % Conver
    S = X1;
    DS = kron(S',I)+kron(I,S);
    XX = X;
    for j=1:i-1
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
        Conv2(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        Conv3(j) = norm((X{j} - S),'fro') / (norm(S,'fro'));
        Conv4(j) = norm(X{j+1}^2 - A,'fro');
    end

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
    t3 = title('log${||F(X_{i+1})||}$');
    set(t3,'Interpreter','Latex');

    subplot(2,2,4)
    semilogy(Conv3,'-o')
    t4 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
    set(t4,'Interpreter','Latex');
    
    
    
end

end