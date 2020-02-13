function [S, Xs, Ys, nXSs, nYSs, i, time] = NewtonPoly(A,X0,minp,maxiter)

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



if nargin < 4                                                               % Auto Max Iteration
    maxiter = 100;
end

if nargin < 3                                                               % Auto Tolerance
    minp = m*10^(-16);
    %minp = 10^(-16);
    %minp = 2^(-53);
end


i = 1;                                                                      %Initialize
I = eye(m);
pert = 1;
tic;
PmialX0 = Polynom(X0,A);
Xs = nan(m,m,maxiter);
Ys = nan(m,m,maxiter);
Xs(:,:,i) = X0;
Ys(:,:,i) = X0;

while (norm(PmialX0,'fro') > minp) && (i < maxiter)
    %fprintf('i : %d\n',i)                                                   % Experiment
    P_X0 = zeros(m^2);
    for j=1:n-1                                                               % P_X
        for k=1:j
            P_X0 = P_X0 + kron(X0'^(j-k),A(:,:,j+1)*X0^(k-1));
        end
    end
    vP = -(Polynom(X0,A));
    vP = vP(:);
    vH = P_X0 \ vP;
    H = reshape(vH,m,m);
    X0 = X0 + H;
    PmialX0 = Polynom(X0,A);
    i = i + 1;                                                              % Prepare for Next Iteration
    Xs(:,:,i) = X0;
    Ys(:,:,i) = X0 + H;
        
end
time = toc;

if i >= maxiter                                                             % The Iteration over the Max Iteration
    S = X0;
    
else                                                                        % Conver
    S = X0;
    Xs = Xs(:,:,1:i);
    Ys = Ys(:,:,1:i);
    Ss = S;
    for k = 1:i-1
        Ss = cat(3,Ss,S);
    end
    XSs = Xs - Ss;
    YSs = Ys - Ss;
    for k = 1:i
        nXSs(k) = norm(XSs(:,:,k),'fro');
        nYSs(k) = norm(YSs(:,:,k),'fro');
        nFXs(k) = norm(Polynom(Xs(:,:,k),A),'fro');
        nFYs(k) = norm(Polynom(Ys(:,:,k),A),'fro');
    end
    
    subplot(1,2,1);
    semilogy(nXSs,'-o');hold on;
    semilogy(nYSs,'-v');hold off;
    
    subplot(1,2,2);
    semilogy(nFXs,'-o');hold on;
    semilogy(nFYs,'-v');hold off;
    
%     figure(2);
%     plot(Conv(1:length(Conv)-2)./Conv(2:length(Conv)-1),'-o');
    
    
end

end