clear
By = [100:100:1000];
t1 = 0;
t2 = 0;
i = 1;
for n=By
    BB = full(gallery('tridiag',n,-1,4,-1));
    A = inv(BB);
    B = A;
    C = -A;
    I = eye(n);
%     A1 = inv(A);
%     C1 = A\C;
    tic;
    X1 = sylvester(BB,C,I);
    t1(i) = toc;
    [X2,~,~,t2(i)] = GSyl(A,B,C);
    i = i + 1
    norm(X2 - A*X2*B - C,'fro')
end

plot(By,t1,'-ro');
hold on;
plot(By,t2,'-b*');
legend('Bulit-in','Series Sylvester');
hold off