clear
By = [50:50:500];
t1 = 0;
t2 = 0;
i = 1;
for n=By
    sigma = 54.461;
    sigman = 17.2221;
    rx = .5;
    ry = .5;

%     m = 240;
%     n = 256;

    A = -sigman/sigma * ImageRes(ry,n);
    B = sigman/sigma * ImageRes(rx,n);
    C = rand(n);
    A1 = inv(A);
    C1 = A\C;
    tic;
    X1 = sylvester(A1,-B,C1);
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