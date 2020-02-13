function [S, H] = Halley_Poly(A,X0,grph,minp,maxiter)

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
n = n - 1;


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


iter = 1;                                                                      %Initialize
I = eye(m);
%X{i} = X0;
pert = 1;

tic;
while (pert > minp) & (iter < maxiter)
    P_X0 = Polynom(X0,A);
%     Q_X0 = Polynom(X0,A(:,:,2:n+1));
    P1_X0 = zeros(m^2);
    for i=1:n
        for j=0:i-1
            P1_X0 = P1_X0 + kron((X0')^(i-j-1),A(:,:,i+1)*X0^j);
        end
    end
    
    P11_X0 = zeros(m^2);
%     for i=2:n
%         for j=0:i-2;
%             for l=0:i-2-j
%                 P11_X0 = P11_X0 + kron((X0')^(i-j-l-2),A(:,:,i+1)*X0^j*P_X0*X0^l) + kron((X0^l*P_X0*X0^(i-j-l-2))',A(:,:,i+1)*X0^j);
%             end
%         end
%     end
    for i=1:n-1
%         for j=0:i-1
            P11_X0 = P11_X0 + kron(I,A(:,:,i+2)*X0^(i-1)*P_X0);
%         end
    end


    vP = reshape(P_X0,m^2,1);
    vH = pinv(2*(P1_X0)^2 - P11_X0) * (-2*P1_X0*vP);
    H{iter} = reshape(vH,m,m);
    X0 = X0 + H{iter};
    
    pert = norm(H{iter},'fro');
    iter = iter + 1;
end
toc

if iter >= maxiter                                                             % The Iteration over the Max Iteration
    S = X0;
    
else                                                                        % Conver
    S = X0;
    
    
end
iter
end