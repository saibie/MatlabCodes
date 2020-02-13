function [X, iter, res, t] = Jiepthroot3(A,Q,p,opt)

tol = 1e-15;
%A=A/100;
m = length(A);
%Q = eye(m);
I = eye(m);
X0=eye(m);
X=X0;
iter = 1;
tic;

while(1)
    switch opt
        case 1
            X=(Q-A'*X*A)^(1/p);

% Newton's method 
        case 2
            X=(1/p)*((p-1)*X+(Q-A'*X*A)*inv(X^(p-1)));

% Newton's method + diagonal update            
        case 3
            B=Q-A'*X*A;
            d=min(abs(diag(B)));
            X=(1/p)*((p-1)*X+(B+d*X)*inv(X^(p-1)+d*I));

            
% Halley method
        case 4
            X =X*inv((p+1)*X^p+(p-1)*(Q-A'*X*A))*((p-1)*(X^p)+(p+1)*(Q-A'*X*A));

% Halley method 2
        case 5
            X =((p-1)*X^p+Q)/((X^(p-1))+A'*A/p)/p;            
            
            
            % Halley method + diagonal update
        case 6
            d=min(abs(diag(X)));
            X =((p+1)*(X^p+d*X^(p-1))+(p-1)*A)\((p-1)*X^p+(p+1)*A*(X+d*I));

            
            
            
    end
    if norm(X-X0,'inf') < m*tol
        res = norm(X^p+A'*X*A-Q,'inf');
        t = toc;
        break;
    end
%    eig(X-X0)
    X0 = X;
    
    iter = iter + 1;
end