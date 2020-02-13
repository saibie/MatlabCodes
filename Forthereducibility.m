clear
sen = 'n×n matrix에 대해 실험할 겁니다. : ';
n = input(sen);
for i=1:n
    for j=1:n
        a(i,j) = 10*i+j;
    end
end
In = eye(n);
Inn = eye(n^2);
On = ones(n);
A = kron(On,a);
for i=1:n
    for j=1:n
        P1(n*(i-1)+j,n*(j-1)+i) = 1;
    end
end
p = randperm(n^2);
P = Inn(:,p);
PAP = P'*A*P;
PAP0 = PAP;
m = ceil(rand(1)*(n-1));
k = n - m;
disp(sprintf('%d·%d×%d·%d zero block matrix',m,n,k,n))
for i = n*k+1:n^2
    for j = 1:k*n
        PAP0(i,j) = 0;
    end
end
