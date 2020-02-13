function [S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4, PofX] = DU_Poly2(A,X0,grph,minp,maxiter)

nA = size(A);
if nargin < 2
    X0 = zeros([nA(1) nA(2)]);
end
nX0 = size(X0);

if ~((nA(1)==nA(2))&&(nX0(2)==nX0(1))&&(nA(1)==nX0(1)))                     % Are the size of matrices right?
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
    maxiter = 3000;
end

if nargin < 4                                                               % Auto Tolerance
    minp = m*10^(-10);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
I = eye(m);
X{i} = X0;
pert = 1;


while (pert > minp) && (i < maxiter)
%     delta = min([1; abs(diag(X0))])
%     delta = max(abs(diag(X0)))
%     delta = mean([min([1; abs(diag(X0))]),max(abs(diag(X0)))])
%     delta = trace(X0)/m
%     delta = min([1,max(max(abs(X0)))])
%     delta = min(diag(DU_polynom2(X0,A)))
    delta = min([diag(DU_polynom2(X0,A));min(min(A(:,:,1)./X0))])
    eig(-(Polynom(X0,A(:,:,2:end)) + delta*I))
    (A(:,:,1) - delta*X0)
    X1 = -(Polynom(X0,A(:,:,2:end)) + delta*I)\(A(:,:,1) - delta*X0);
%     X1 = -(Polynom(X0,A(:,:,2:end)) + delta*A(:,:,end))\(A(:,:,1) - delta*A(:,:,end)*X0);
    
    X{i+1} = X1;
    if i == 1
        RE(i) = 0;
    else
        RE(i) = norm(X1,'fro')/norm(X0,'fro');                              % Relative Error
    end
    
    %normX1 = norm(X1,'fro');
    %pert = norm(Polynom(X1,A),'fro')/normP;
    pert = norm(Polynom(X1,A),'fro');
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
        Conv4(j) = norm(Polynom(X{j+1},A),'fro');
    end
    figure(2)
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
        figure(2)
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

function Y = DU_polynom2(X,A)

    if nargin < 2
        disp('Input every coefficient matrix and X0. (by Q)');
        return
    end

    nA = size(A);
    nX0 = size(X);

    if ~((nA(1)==nA(2))&(nX0(2)==nX0(1))&(nA(1)==nX0(1)))                     % Are the size of matrices right?
        disp('The size of A`s and X0 are not right. (by Polynomial)');
        return
    else
        Y = zeros(nA(1));
        for i=nA(3):-1:3
            Y = Y*X + sum(A(:,:,i:end),3);
        end
        Y = Y + sum(A(:,:,i:end),3);
    end
    
end