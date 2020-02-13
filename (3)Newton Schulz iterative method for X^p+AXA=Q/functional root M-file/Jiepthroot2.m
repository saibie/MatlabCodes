function [X, iter, res, t] = Jiepthroot2(A,p,opt)

tol = 1e-15;
A=A/100;
m = length(A);
Q = eye(m);
I = eye(m);
X0=eye(m);
X=X0;
iter = 1;
tic;
%B=[0 0 1;0 1 0;1 0 0];
while(1)
    switch opt
        case 1
            X=(Q-A'*X*A)^(1/p);
%                                   norm(I-(1/p)*A'*A*(X^(1-p)),2)
        case 2
            X=(1/p)*((p-1)*X+inv(X^(p-1))*(Q-A'*X*A));


            if norm(I-(1/p)*A'*A*(X^(1-p)),2)>1
                disp('error')
                break
            end
        case 3
            X=(1/p)*((p-1)*X+(Q-A'*X*A)*inv(X^(p-1)));

    end
    if norm(X-X0,'inf') < m*tol
        res = norm(X^p+A'*X*A-Q,'inf');
        t = toc;
        break;
    end
%    eig(X);
    X0 = X;
    iter = iter + 1;
end
