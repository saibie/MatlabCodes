function CompareFigure(A)
hold on

[m,n]=size(A);
I = eye(m);
X0=eye(m);
X=X0;
iter = 1;
tic;


[X, iter, t] = Jiepthroot2(A,2,opt);
X=I;
x1=zeros(iter1,1);
for i=1:1:iter1;
    X=(1/p) * ( (p-1)*X + A*(X^(1-p)) );
    x1(i)= log10(norm(I-A*(X^(-p)),2));
end 

% 
% [X2, iter2, res, t2] = pthroot(A,p,2);
% X=I;
% x2=zeros(iter2,1);
% for i=1:1:iter2;
%     X=(1/p) * ( (p-1)*X + (A+d*X) * inv( X^(p-1) + d*I ) );
%     x2(i)=log10(norm(I-A*(X^(-p)),2));
% end
% 



[X3, iter3, res, t3] = pthroot(A,p,3);
X=I;
x3=zeros(iter3,1);
for i=1:1:iter3;
    X=(1/p) * ( (p-1)*X + (A+d*I) * inv( X^(p-1) + d*inv(X) ) );
    x3(i)=log10(norm(I-A*(X^(-p)),2));
end


[X4, iter4, res, t4] = pthroot(A,p,4);
X=I;
x4=zeros(iter4,1);
for i=1:1:iter4;
    if i<2;
        X=(1/p) * ( (p-1)*X + (A+d*I) * inv( X^(p-1) + d*inv(X) ) );
    else
        X=(1/p) * ( (p-1)*X + A*(X^(1-p)) );
    end
        
    x4(i)= log10(norm(I-A*(X^(-p)),2));
end

plot(x1,'or');
% plot(x2,'*b');
plot(x3,'.b');
plot(x4,'dk');

    xlabel('Iteration number')
    ylabel('Residual')
    legend('pure Newton','Diagonal update','Newton+diagonal update')