clear
By = [3:3:21];
t1 = 0;
t2 = 0;
i = 1;
for n=By
    T = full(gallery('tridiag',n,-1,4 + (150)/((n+1)^2),-1));
    BB = kron(eye(n),T) + kron(full(gallery('tridiag',n,1,0,1)),-eye(n));
    AA = (1/8)*full(gallery('tridiag',n^2,1,2,1));
    CC = (1/120)*full(gallery('tridiag',n^2,-1,4 + (150)/((n+1)^2),-1));
    A = BB\AA;
    B = BB\CC;
    C = -B;
    A1 = AA\BB;
    C1 = AA\CC;
    tic;
    X1 = sylvester(A1,-B,C1);
    t1(i) = toc;
    [X2,~,~,t2(i)] = GSyl(A,B,C);
    i = i + 1
    norm(X2 - A*X2*B - C,'fro')
end

plot(By.^2,t1,'-ro');
hold on;
plot(By.^2,t2,'-b*');
legend('Bulit-in','Series Sylvester');
hold off