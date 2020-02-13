function Compare2(A,B,C)

hold on

[X, iter0, res, t] = BI_diagonalupdate(B,C,2,0);
m = length(B);
X0 = zeros(m);
X = X0;
I = eye(m);
a=0;
x0=zeros(iter0,1);
for i=1:1:iter0;
            d = min(abs(diag(X)));
            X=(-B+a*d*I)\(X*X+a*d*X+C);
    pert=norm(X^2+B*X+C,'inf');
    x0(i)=log10(pert);
end

[X, iter1, res, t] = BI_diagonalupdate(B,C,2,1);
m = length(B);
X0 = zeros(m);
X = X0;
I = eye(m);
a=1;
x1=zeros(iter1,1);
for i=1:1:iter1;
            d = min(abs(diag(X)));
            X=(-B+a*d*I)\(X*X+a*d*X+C);
    pert=norm(X^2+B*X+C,'inf');
    x1(i)=log10(pert);
end
[X, iter2, res, t] = BI_diagonalupdate(B,C,2,2);
m = length(B);
X0 = zeros(m);
X = X0;
I = eye(m);
a=2;
x2=zeros(iter2,1);
for i=1:1:iter2;
            d = min(abs(diag(X)));
            X=(-B+a*d*I)\(X*X+a*d*X+C);
    pert=norm(X^2+B*X+C,'inf');
    x2(i)=log10(pert);
end

    plot(x0,'or');
    plot(x1,'*k');
    plot(x2,'db');
        xlabel('Iteration number')
    ylabel('Residual')
    legend('BI2','BI2-DU1','BI2-DU2')