function [X, iter, res, t] = Jiepthroot1(p,opt)

tol = 1e-15;
%A=[.9 0 0 ;0 .1 .2; 0 .2 .8];
%Q=[2 -1 -1 ;-1 2 1; -1 1 2];
A=[0.5 -0.45;0.45 0];
Q=[1 0; 0 1];

% A=[0.2 0.4;0.05 025];
% Q=[1 0; 0 1];

m = length(A);
X0=eye(m);
I=eye(m);
X=X0;
iter = 1;
tic;
B=[0 1;1 0];





    switch opt
        
% built in function 을 이용한 p-th root        
        case 1
            X=(Q-A'*X*A)^(1/p);
            
%             if i==1
%             X=zeros(m);
%             X=(Q-A'*X*A)^(1/p);
%             else
%                  X=(Q-A'*X*A)^(1/p);
%             end

%              B=Q-A'*X*A;
%              [X iter] = pthroot(B,p,1);
%              iter
% Newton's method with starting matrix I at each steps        
% 수렵안함

        case 2
            
            X=(1/p)*((p-1)*I+(Q-A'*X*A));
% Newton's method        
        case 3
            
            X=(1/p)*((p-1)*X+(Q-A'*X*A)*inv(X^(p-1)));
%            X=(1/p)*((p-1)*X1+(Q-A'*X*A)*inv(X1^(p-1)));
%             X3=(1/p)*((p-1)*X2+(Q-A'*X*A)*inv(X2^(p-1)));
%             X4=(1/p)*((p-1)*X3+(Q-A'*X*A)*inv(X3^(p-1)));
%             X5=(1/p)*((p-1)*X4+(Q-A'*X*A)*inv(X4^(p-1)));
%             X6=(1/p)*((p-1)*X5+(Q-A'*X*A)*inv(X5^(p-1)));
%             X7=(1/p)*((p-1)*X6+(Q-A'*X*A)*inv(X6^(p-1)));            
%             X8=(1/p)*((p-1)*X7+(Q-A'*X*A)*inv(X7^(p-1)));            
%             X=(1/p)*((p-1)*X8+(Q-A'*X*A)*inv(X8^(p-1)));                        
%            norm(I-(1/p)*A'*A*(X^(1-p)),2)

% Halley method
        case 4
            X =X*inv((p+1)*X^p+(p-1)*(Q-A'*X*A))*((p-1)*(X^p)+(p+1)*(Q-A'*X*A));
  
    end
    
    if norm(X-X0,'fro') < m*tol || iter>100
        res = norm(X^p+A'*X*A-Q,2);
        t = toc;
        break;
    end
%     if min(eig(X))< m*tol
%         break;
%     end
%Q-A'*X*A-X^p
%eig(X^(p-1))
%     eig((p-1)*X+(Q-A'*X*A)*inv(X^(p-1)))
%     norm((p-1)*X+(Q-A'*X*A)*inv(X^(p-1)))
%eig(X-X0)
%     eig( X-(Q-A'*X*A)*(X^(1-p)))
%     eig( X-(Q-A'*X*A)*(X^(1-p)) - (X0-(Q-A'*X0*A)*(X0^(1-p))))

% eig((I-(1/p)*A'*A*(X^(1-p)))*(X0^(-p)))

%eig(I-(Q-A'*X*A)*(X^(-p)))
%eig((Q-A'*X0*A)-(Q-A'*X*A))

% eig(Q-A'*X*A)
%    eig(Q-X^p)

%eig(I-Q+A'*X*A)
    X0 = X;
       
    iter = iter + 1;
%    i=i+1;
end