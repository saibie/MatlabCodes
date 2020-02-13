function [X, iter, res] = pthroot(A,p,opt)

tol = 1e-15;
%A=rand(10)/100;
%m = length(A);
%Q = eye(m);
%I = eye(m);
%X0=I;
%X=X0;
iter = 1;
%tic;
% we regard A is idenity 
m = length(A);
I = eye(m);
X0=I;
X=I;
y=0;
            d=(min(abs(diag(A))))^(1/p);
while(1)
    switch opt
    % Neton's method
        case 1
            X=(1/p)*((p-1)*X+A*(X^(1-p)));
    % Newton's method + diagonal update 1
        case 2
%            d=min(abs(diag(X)));
            X=(1/p)*((p-1)*X+(A+d*X)*inv(X^(p-1)+d*I));
%            x(iter)=iter; 
%            y(iter)=norm(I-(A+d*I)/(X^p+d*I),2);

    % Newton's method + diagonal update 2    
        case 3
%            d=min(abs(diag(X)));
            X=(1/p)*((p-1)*X+(A+d*I)*inv(X^(p-1)+d*inv(X)));
            
    % Halley method
        case 4
            X =X*inv((p+1)*X^p+(p-1)*A)*((p-1)*(X^p)+(p+1)*A);

        case 5
            d=min(abs(diag(X)));
            X =((p+1)*(X^p+d*X^(p-1))+(p-1)*A)\((p-1)*X^p+(p+1)*A*(X+d*I));

    end
    if norm(X-X0,'inf') < m*tol
        res = norm(X^p-A,'inf');
%        t = toc;
        break;
    end

    y(iter)=norm(I-A*(X^(-p)),2);
    X0 = X;
    semilogy(iter,y(iter),'r*')
    hold on
    iter = iter + 1;
end