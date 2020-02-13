clear
n = 500;
t1 = zeros(n,1);
t2 = t1;
for m = 1:n
    A = rand(m); A = (max(abs(eig(A)))+.05)\A;
    B = rand(m); B = (max(abs(eig(B)))+.05)\B;
    C = rand(m);
    
    tic;
    X = sylvester(inv(A),-B,A\C);
    t1(m) = toc;
    
    tol = 1; %i = 0;
    S = C;
    tic;
    while tol > 1e-16
        S1 = S + A*S*B;
        A = A^2;
        B = B^2;
        tol = norm(S1 - S,'fro');
        S = S1; %i = i + 1;
    end
    t2(m) = toc;%fprintf('%d\n',i);
end
hold off;plot(t1,'-or');hold on;plot(t2,'-ob');