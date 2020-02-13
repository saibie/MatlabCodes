function [S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4, PofX] = NM_Poly1(A,X0,grph,minp,maxiter)

nA = size(A);
if nargin < 2
    X0 = zeros([nA(1) nA(2)]);
end
nX0 = size(X0);

if ~((nA(1)==nA(2))&(nX0(2)==nX0(1))&(nA(1)==nX0(1)))                     % Are the size of matrices right?
    disp('The size of A`s and X0 are not right. (by Polynomial)');
    return
else
    m = nA(1);
    if length(nA) < 3
        disp('We need more coefficient matrices. (by n = 1)');
        return
    else
        n = nA(3);
    end
end



if nargin < 3
    grph = 1;
end

if nargin < 5                                                               % Auto Max Iteration
    maxiter = 100;
end

if nargin < 4                                                               % Auto Tolerance
    minp = m*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
I = eye(m);
X{i} = X0;
pert = 1;


while (pert > minp) & (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    P_X0{i} = zeros(m^2);
    normP = 0;
    for j=[1:n-1]                                                              % P_X
        for k=1:j
            P_X0{i} = P_X0{i} + kron(X0'^(j-k),A(:,:,j+1)*X0^(k-1));
        end
        normP = normP + norm(A(:,:,j+1),'fro')*norm(X0,'fro')^j;
    end
    normP = normP + norm(A(:,:,1),'fro');
    %P_X0{i} = kron(In,X0*C) + kron(X0'*C',Im) - kron(D',Im) - kron(In,A);
    vP{i} = reshape((-(Polynom(X0,A))),m^2,1);
    vH = pinv(P_X0{i}) * vP{i};
    H{i} = reshape(vH,m,m);
    X1 = X0 + H{i};
    X{i+1} = X1;
    if i == 1
        RE(i) = 0;
    else
        RE(i) = norm(X1,'fro')/norm(X0,'fro');                              % Relative Error
    end
    
    normX1 = norm(X1,'fro');
    pert = norm(Polynom(X1,A),'fro')/normP;
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
    PofX = 0;
    for j=1:(maxiter - 2)
        Conv3(j) = norm((X{j+1} - S),'fro') / (norm((X{j+1}),'fro'));
    end
    for j=1:(maxiter - 2)
        Conv4(j) = norm(Polynom(X{j+1},A),'fro');
    end
    semilogy(Conv4,'-o')
    t3 = title('log${||P(X_{i+1})||}$');
    set(t3,'Interpreter','Latex');
    
else                                                                        % Conver
    S = X1;
    DS = 0;
    for j=1:n-1                                                               % DS
        for k=1:j
            DS = DS + kron(S^(j-k),A(:,:,j+1)*S^(k-1));
        end
    end
    XX = X;
    for j=1:i-2
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
        Conv2(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        Conv3(j) = norm((X{j} - S),'fro') / (norm(S,'fro'));
        Conv4(j) = norm(Polynom(X{j+1},A),'fro');        
    end
    Conv3(i-1) = norm((X{i-1} - S),'fro') / (norm(S,'fro'));
    Conv4(i-1) = norm(Polynom(X{i},A),'fro');
    for j=1:i;PofX{j} = Polynom(X{j},A);end

    if grph == 1
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
        t3 = title('log${||P(X_{i+1})||}$');
        set(t3,'Interpreter','Latex');

        subplot(2,2,4)
        semilogy(Conv3,'-o')
        t4 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
        set(t4,'Interpreter','Latex');
    end
    
    
%     figure(2);
%     plot(Conv(1:length(Conv)-2)./Conv(2:length(Conv)-1),'-o');
    
    
end

end