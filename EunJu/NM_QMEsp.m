function [S, ST, XX, H, D_X0, DS, vQ, RE, Conv, Conv2, Conv3] = NM_QMEsp(n,minp,maxiter)

% S : solvent
% XX : The Newton Iteration
% H : Seq. of H's
% D_X0 : Seq. of D_Xi's
% DS : D_S
% vQ : vec(Q(X_i))
% RE : Relative Errors

A = ones(n)/(3*n-3);                                                        % Initializing A,B,C,X0
X0 = zeros(n);
I = eye(n);
for i=1:n
    A(i,i)=0;
end
B = A - I;
C = A;


for i=1:n-1                                                                 % Eigenvector Matrix P
    P1(i,i)=1;
    P1(i+1,i)=-1;
end

P = [ones(n,1) P1];

invP = ones(1,n)/n;                                                         % Inverse of P
for i=1:n-1
    for j=1:n
        if j>i
            invP(i+1,j)= - i/n;
        else
            invP(i+1,j)= (n-i)/n;
        end
    end
end

SD = diag([1 (ones(1,n-1)*(2 - 3*n + sqrt(9*n^2 - 12*n))/2)]);              % Diagonalized Solvent
ST = P*SD*invP;                                                              % True Solvent


if nargin < 3                                                               % Auto Max Iteration
    maxiter = 1000;
end

if nargin < 2                                                               % Auto Tolerance
    minp = n*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
X{i} = X0;
pert = 1;

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
    
    pert = norm(Qu(X1,A,B,C),'fro');
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
    for j=1:(maxiter - 1)
        Conv3(j) = norm((X{j+1} - S),'fro') / (norm((X{j+1}),'fro'));
    end
    for j=1:(maxiter - 1)
        Conv4(j) = norm(Qu(X{j+1},A,B,C),'fro');
    end
else                                                                        % The Iteration Converges
    S = X1;
    DS = kron(S',A)+kron(I,A*S)+kron(I,B);
    XX = X;
    
    
    figure(1)                                                               % Figure 1
    for j=1:i-1
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
        Conv2(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        Conv3(j) = norm((X{j+1} - S),'fro') / (norm(S,'fro'));
        Conv4(j) = norm(Qu(X{j+1},A,B,C),'fro');
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
    t3 = title('log${||Q(X_{i+1})||}$');
    set(t3,'Interpreter','Latex');

    subplot(2,2,4)
    semilogy(Conv3,'-o')
    t4 = title('log$({||X_{i+1}-S||}~ /~ {||S||})$');
    set(t4,'Interpreter','Latex');
    
    
    
    figure(2)                                                               % Figure 2
    for j=1:i-1
        Conv(j) = norm((X{j+1} - ST),'fro') / norm((X{j} - ST),'fro');
        Conv2(j) = norm((X{j+1} - ST),'fro') / (norm((X{j} - ST),'fro')^2);
        Conv3(j) = norm((X{j+1} - ST),'fro') / (norm(ST,'fro'));
        Conv4(j) = norm(Qu(X{j+1},A,B,C),'fro');
    end
    Conv4(length(Conv4)+1) = norm(Qu(ST,A,B,C),'fro');
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
    t4 = title('log$({||X_{i+1}-ST||}~ /~ {||ST||})$');
    set(t4,'Interpreter','Latex');
    
    
end

end