function [s, Time] = Time_NM_MBT(a,B,x0,minp,maxiter)

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
%     x1 = f1_x0 \ (a - B*kron(x0,x0));
    
    h = f1_x0 \ (MBT(x0,a,B));
    x1 = x0 + h;
    
    normx1 = norm(x1,'fro');
    pert = norm(MBT(x1,a,B),'fro')/(normx1 + norma + normB*normx1^2);
    
    i = i + 1;                                                              % Prepare for Next Iteration
    x0 = x1;
        
end;Time = toc;

s = x1;


end