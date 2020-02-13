function Compare1(A,B,C)

hold on

[X, iter1, res, t] = BI_diagonalupdate(B,C,1,0);
a=0;
x1=zeros(iter1,1);
m = length(B);
X0 = zeros(m);
X = X0;
I = eye(m);
for i=1:1:iter1;
            d = min(abs(diag(X)));
            X = -(B+X-a*d*I)\(C+a*d*X);
    pert=norm(X^2+B*X+C,'fro');
    x1(i)=log10(pert);
end

[X, iter2, res, t] = BI_diagonalupdate(B,C,1,1);
a=1;
x2=zeros(iter2,1);
m = length(B);
X0 = zeros(m);
X = X0;
I = eye(m);
for i=1:1:iter2;
            d = min(abs(diag(X)));
            X = -(B+X-a*d*I)\(C+a*d*X);
    pert=norm(X^2+B*X+C,'fro');
    x2(i)=log10(pert);
end


plot(x1,'or');
    plot(x2,'*k');
    legend('BI1','BI1-DU')
    
        xlabel('Iteration number')
    ylabel('Residual')