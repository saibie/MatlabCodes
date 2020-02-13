function [s, Time, i, x, h, f1_x0, f1_s, Conv, Conv2, Conv3, Conv4] = NM_MBT(a,B,x0,minp,maxiter)

na = size(a);
nB = size(B);
if nargin < 3
    x0 = zeros(na(1),1);                         % Auto Initial Value
    nx0 = na;
else
    nx0 = size(x0);
end


if ~((na(2)==1)&(nx0(2)==1))         % Are they square matrices?
    disp('a and x0 must be a vector.');
    return
elseif ~((na(1)==nB(1))&((nB(1)^2)==nB(2)))                     % Are the size of matrices same?
    disp('a and B must be the size n by 1 and n by n^2, respectively.');
    return
elseif ~((na(1)==nx0(1)))                     % Are the size of matrices same?
    disp('The length of a and x0 must be same.');
    return
else
    n = na(1);
end

if nargin < 4                                                               % Auto Tolerance
    minp = n*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end

if nargin < 5                                                               % Auto Max Iteration
    maxiter = 100;
end


i = 1;                                                                      %Initialize
I = eye(n);
x{i} = x0;
pert = 1000;
norma = norm(a,'fro');
normB = norm(B,'fro');

tic;
while (pert > minp) & (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    f1_x0 = I - B*(kron(I,x0) + kron(x0,I));
    x1 = f1_x0 \ (a - B*kron(x0,x0));
    if i == 1
        RE(i) = 0;
    else
        RE(i) = norm(x1,'fro')/norm(x0,'fro');                              % Relative Error
    end
    h{i} = x1 - x0;
    normx1 = norm(x1,'fro');
    pert = norm(x1 - a - B*kron(x1,x1),'fro')/(normx1 + norma + normB*normx1^2);
    %pert = norm(Qu(X1,A,B,C),'fro');
    %pert = norm(H{i},'fro')/norm(X1,'fro');
    
    i = i + 1;                                                              % Prepare for Next Iteration
    x{i} = x1;
    x0 = x1;
        
end;Time = toc;

if i >= maxiter                                                             % The Iteration over the Max Iteration
    s = x1;
    f1_s = 0;
    RE = 0;
    Conv = 0;
    Conv2 = 0;
%     Conv3 = 0;
%     Conv4 = 0;
    for j=1:(maxiter - 2)
        Conv3(j) = norm((x{j+1} - s),'fro') / (norm((x{j+1}),'fro'));
    end
    for j=1:(maxiter - 2)
        Conv4(j) = norm(B*kron(x{j},x{j}) - x{j} + a,'fro');
    end
%     subplot(1,1,1)
    semilogy(Conv4,'-o')
    t3 = title('log${||Q(X_{i+1})||}$');
    set(t3,'Interpreter','Latex');
    
else                                                                        % Conver
    s = x1;
    f1_s = I - B*(kron(s,I)+kron(I,s));
    Conv = 0;Conv2 = 0;Conv3 = 0;Conv4 = 0;
    for j=1:i-1
%         Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
%         Conv2(j) = norm((X{j+1} - S),'fro') / (norm((X{j} - S),'fro')^2);
        Conv3(j) = norm((x{j} - s),'fro') / (norm(s,'fro'));
%         Conv4(j) = norm(Qu(X{j+1},A,B,C),'fro');
    end
%     
%     subplot(2,2,1)
%     plot(Conv,'-o')
%     t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
%     set(t1,'Interpreter','Latex');
% 
%     subplot(2,2,2)
%     plot(Conv2,'-o')
%     t2 = title('${||\tilde{X_{i+1}}||}~ /~ {||\tilde{X_{i}||^2}}$');
%     set(t2,'Interpreter','Latex');
% 
%     subplot(2,2,3)
%     semilogy(Conv4,'-o')
%     t3 = title('log${||Q(X_{i+1})||}$');
%     set(t3,'Interpreter','Latex');
% 
%     subplot(2,2,4)
%     semilogy(Conv3,'-o');hold on
%     t4 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
%     set(t4,'Interpreter','Latex');
    
    
    
end


end