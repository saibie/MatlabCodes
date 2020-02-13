clear S XX H D_X0 PI_X0 DS vQ RE tXii_tXi tXii_tXisq tXi_S nQX DXDX n qwe qwe2 XV;
n = 2;
[A,B,C] = rstochashigh(n,0.00);
% [A,B,C] = rstochas(n,0.00001);
X0 = zeros(n);
eigX = eig(X0);
minp = n*10^(-12);
maxiter = 10000;


i = 1;                                                                      %Initialize
I = eye(n);
X{i} = X0;
XV{i} = I;
pert = 1;
normA = norm(A,'fro');
normB = norm(B,'fro');
normC = norm(C,'fro');

while (pert > minp) & (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    X1 = -B\(A*X0*X0 + C);
    X{i+1} = X1;
    eigX(:,i+1) = eig(X1);
    [XV{i+1},~] = eig(X1);
    
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
    tXii_tXi = 0;
    tXii_tXisq = 0;
    DS = 0;
    vQ = 0;
    RE = 0;
    tXii_tXi = 0;
    tXii_tXisq = 0;
    for j=1:(maxiter - 2)
        tXi_S(j) = norm((X{j+1} - S),'fro') / (norm((X{j+1}),'fro'));
    end
    for j=1:(maxiter - 2)
        nQX(j) = norm(Qu(X{j+1},A,B,C),'fro');
    end
    subplot(1,1,1)
    semilogy(nQX,'-o')
    t3 = title('log${||Q(X_{i+1})||}$');
    set(t3,'Interpreter','Latex');
    
else                                                                        % Conver
    S = X1;
%     P = [1 -1 0 ; 1 1 -1 ; 1 0 1];S = P*diag([1,(-7 + sqrt(45))/2,(-7 + sqrt(45))/2])/P;
    DS = kron(S',A)+kron(I,A*S)+kron(I,B);
    XX = X;
    for j=1:i-1
        tXii_tXi(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
        tXii_tXisq(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        tXi_S(j) = norm((X{j} - S),'fro') / (norm(S,'fro'));
        nQX(j) = norm(Qu(X{j+1},A,B,C),'fro');
%         DXDX(j) = min(abs(eig(D_X0{j})));
%         Conv5(j) = max(reshape(X{j+1} - X{j},n^2,1));
%         Conv6(j) = min(reshape(X{j+1} - X{j},n^2,1));
%         Conv7(j) = max(reshape(X{j+1} - X{j},n^2,1))/max(reshape(X{j+1},n^2,1));
%         Conv8(j) = max(reshape(S - X{j+1},n^2,1))/max(reshape(S - X{j},n^2,1));
        
    end
    
%     qwe = []; qwe2 = [];
%     for j=1:i-1;
%         qwe = [qwe;max(abs(eig(PI_X0{j})))];
%         qwe2 = [qwe2;norm(PI_X0{j},2)];
%     end
    
    figure(1);
    subplot(2,2,1)
    plot(tXii_tXi,'-o')
    t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
    set(t1,'Interpreter','Latex');

    subplot(2,2,2)
    plot(tXii_tXisq,'-o')
    t2 = title('${||\tilde{X_{i+1}}||}~ /~ {||\tilde{X_{i}||^2}}$');
    set(t2,'Interpreter','Latex');

    subplot(2,2,3)
    semilogy(nQX,'-o')
    t3 = title('log${||Q(X_{i+1})||}$');
    set(t3,'Interpreter','Latex');

    subplot(2,2,4)
    semilogy(tXi_S,'-o')
    t4 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
    set(t4,'Interpreter','Latex');
    
%     figure(2);
%     subplot(2,1,1)
%     semilogy(DXDX,'-o')
%     t5 = title('log(min(abs(eig$(D_{X_{i}})$)))');
%     set(t5,'Interpreter','Latex');
%     
%     subplot(2,1,2)
%     plot(qwe,'-o');
%     hold on;plot(tXii_tXi,'-or');hold off
%     t6 = title('$\rho(\Psi_{X_{i}}^{\prime})$');
%     set(t6,'Interpreter','Latex');
%     
%     [qwe,qwe2];
    
%     figure(2);
%     subplot(2,4,3)
%     semilogy(Conv5,'-o')
%     t5 = title('${\mathrm{max}(X_{i+1} - X_{i})}$');
%     set(t5,'Interpreter','Latex');
% 
%     subplot(2,4,4)
%     semilogy(Conv6,'-o')
%     t6 = title('${\mathrm{min}(X_{i+1} - X_{i})}$');
%     set(t6,'Interpreter','Latex');
% 
%     subplot(2,4,7)
%     semilogy(Conv7,'-o')
%     t7 = title('${\mathrm{max}(X_{i+1} - X_{i})} / \mathrm{max}(X_{i+1})$');
%     set(t7,'Interpreter','Latex');
% 
%     subplot(2,4,8)
%     plot(Conv8,'-o')
%     t4 = title('$A$');
%     set(t4,'Interpreter','Latex');
    
    AA = [zeros(n),eye(n);-C,-B];
    BB = [eye(n),zeros(n);zeros(n),A];
    [Ta,Tb,Qab,Zab,Va,Vb] = qz(AA,BB);
    Lamb = diag(Ta)./diag(Tb);
    [V,D] = eig(S);
    hA = V\A*V; hB = V\B*V; hC = V\C*V;
    VVa = Va(1:n,n+1:2*n);SL = VVa*D/VVa;
%     SL,S

% Eigenvalue Steps
    a = eig(A);b = eig(B);c = eig(C);
    x0 = zeros(n,i);
    normXS = zeros(i,1);
    eigXS = zeros(n,i);
    for j = 1:i
        x0(:,j+1) = -(a.*x0(:,j).*x0(:,j) + c)./b;
        normXS(j) = norm(S - X{j},'fro');
%         normXS(j) = max(abs(eig(X{i} - X{j})));
        eigXS(:,j) = abs(eig(S) - eigX(:,j));
    end

    figure(3)
    slogy(1) = subplot(2,n+1,1);
    semilogy(nQX,'-o');
    t7 = title('log${||Q(X_{i+1})||}$');
    set(t7,'Interpreter','Latex');
    
    slogy(n+2) = subplot(2,n+1,n+2);
    semilogy(normXS,'-o');
    xlim(slogy(n+2),slogy(1).XLim);
    ylim(slogy(n+2),slogy(1).YLim);
    t8 = title('log${||X_{i} - S||}$');
    set(t8,'Interpreter','Latex');
    for j = 1:n
        slogy(j+1) = subplot(2,n+1,j+1);
        semilogy(abs(a(j).*x0(j,:).*x0(j,:) + b(j).*x0(j,:) + c(j)),'-o');
        xlim(slogy(j+1),slogy(1).XLim);
        ylim(slogy(j+1),slogy(1).YLim);
        
        slogy(n+j+2) = subplot(2,n+1,n+j+2);
        semilogy(eigXS(j,:),'-o');
        xlim(slogy(n+j+2),slogy(1).XLim);
        ylim(slogy(n+j+2),slogy(1).YLim);
    end
end