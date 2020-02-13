function [X, iter, res, t] = BI_diagonalupdate(B,C,opt,a)
if nargin < 6
    tol = 1e-16;
end 
if nargin < 3
    opt = 1; % opt Standard
end

m = length(B);
X0 = zeros(m);
X = X0;
I = eye(m);
iter = 0;
tic;
% we regard A is idenity 

while(1)
    switch opt
        case 1
            d = min(abs(diag(X)));
            X = -(B+X-a*d*I)\(C+a*d*X);
        case 2
            d = min(abs(diag(X)));
            X=(-B+a*d*I)\(X*X+a*d*X+C);
        case 3
            X =a*X-(1-a)*(B+X)\(C);
        case 4
            X =a*X-(1-a)*(B)\(X^2+C);
        case 5
            d = -max(abs(diag(X)));
            X = -(B+X+d*I)\(C-d*X);
        case 6
            X = -(B+X)\C;
                        
    end
    if norm(X-X0,'inf') < m*tol
        res = norm(X^2+B*X+C,'fro');
        t = toc;
        break;
    end
    X0 = X;
    iter = iter + 1;
end

    