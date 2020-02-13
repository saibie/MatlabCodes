clear
By = [50:50:1000];
t1 = 0;
t2 = 0;
ii = 1;

alpha = 15;
beta = 2;
for n=By
    AA = ones(n)./alpha;
    for i=1:n
        for j=1:n
            if i+j == n+1
                AA(i,j) = 2/alpha;
            end
        end
    end
    BB = zeros(n);
    for i=1:n;
        for j=1:n;
            if i==j;
                BB(i,j)=15;
            elseif i+1==j;
                BB(i,j)=-3;
            elseif i==j+n-2;
                BB(i,j)=-3;
            else
                BB(i,j)=-1;
            end
        end
    end 
    CC = zeros(n);
    for i=1:n
        for j=1:n;
            if i==j;
                CC(i,j)=15/beta;
            else
                CC(i,j)= -1/beta;
            end
        end
    end
    A = BB\AA;
    B = BB\CC;
    C = -B;
    A1 = AA\BB;
    C1 = AA\CC;
    tic;
    X1 = sylvester(A1,-B,C1);
    t1(ii) = toc;
    [X2,~,~,t2(ii)] = GSyl(A,B,C);
    ii = ii + 1
    norm(X2 - A*X2*B - C,'fro')
end

plot(By,t1,'-ro');
hold on;
plot(By,t2,'-b*');
legend('Bulit-in','Series Sylvester');
hold off