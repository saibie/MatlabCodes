function [S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4, PofX] = NM_PolyIn2(A,X0, acc, grph,minp,maxiter)

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



if nargin < 4
    grph = 1;
end

if nargin < 6                                                               % Auto Max Iteration
    maxiter = 100;
end

if nargin < 5                                                               % Auto Tolerance
    minp = m*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
I = eye(m);
X{i} = X0;
pert = 1;
husik = 0;

while (pert > minp) && (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    P_X0{i} = zeros(m^2);
    for j=1:n-1                                                               % P_X
        for k=1:j
            P_X0{i} = P_X0{i} + kron(X0'^(j-k),A(:,:,j+1)*X0^(k-1));
        end
    end
    %P_X0{i} = kron(In,X0*C) + kron(X0'*C',Im) - kron(D',Im) - kron(In,A);
    vP{i} = reshape((-(Polynom(X0,A))),m^2,1);
    vH = P_X0{i} \ vP{i};
    H{i} = reshape(vH,m,m);
    if i >= 3
%         X21X10 = norm(X{i-1} - X{i},'fro')/norm(X{i-2} - X{i-1},'fro');
        X21X10 = norm(H{i-1},'fro')/norm(H{i-2},'fro');
    end
    husik = husik - 1;
    if i >= 3 && abs(X21X10 - 1/2) <= acc && husik < 1
        X1 = X0 + 2*H{i};
        %husik = 4;
    else
        X1 = X0 + H{i};
    end
    
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
    DS = 0;
    vQ = 0;
    RE = 0;
    for j=1:(maxiter - 2)
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
        Conv2(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        Conv3(j) = norm((X{j+2} - X{j+1}),'fro') / (norm(X{j+1} - X{j},'fro'));
        Conv4(j) = norm(X{j} - S,'fro');        
    end
    Conv4(i-1) = norm(X{i-1} - S,'fro');

    if grph == 1
        subplot(1,2,1)
        plot(Conv,'-ob')
        hold on;plot(Conv3,'-vr');hold off
        subplot(1,2,2)
        semilogy(Conv4,'-o')
        t4 = title('log$({||X_{i} - S||})$');
        set(t4,'Interpreter','Latex');
    end
    
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
        Conv3(j) = norm((X{j+2} - X{j+1}),'fro') / (norm(X{j+1} - X{j},'fro'));
        Conv4(j) = norm(X{j} - S,'fro');        
    end
%     Conv3(i-1) = norm((X{i-1} - S),'fro') / (norm(S,'fro'));
    Conv4(i-1) = norm(X{i-1} - S,'fro');
    for j=1:i;PofX{j} = Polynom(X{j},A);end

    if grph == 1
        subplot(1,2,1)
        plot(Conv,'-ob')
%         t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
%         set(t1,'Interpreter','Latex');

%         subplot(2,2,2)
%         plot(Conv2,'-o')
%         t2 = title('${||\tilde{X_{i+1}}||}~ /~ {||\tilde{X_{i}||^2}}$');
%         set(t2,'Interpreter','Latex');

%         subplot(1,2,2)
        hold on;plot(Conv3,'-vr');hold off
%         t3 = title('${||X_{i+2} - X_{i+1}|| / ||X_{i+1} - X_{i}||}$');
%         set(t3,'Interpreter','Latex');

        subplot(1,2,2)
        semilogy(Conv4,'-o');ylim([1e-10 10])
        t4 = title('log$({||X_{i} - S||})$');
        set(t4,'Interpreter','Latex');
    end
    
    
%     figure(2);
%     plot(Conv(1:length(Conv)-2)./Conv(2:length(Conv)-1),'-o');
    
    
end

end