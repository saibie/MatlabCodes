n = 50;
A = rand(n)*1e-2;
Q = eye(n);
X0 = eye(n);

tol = 1e-13;
maxiter = 1000;
time1 = zeros(9,1);
time2 = zeros(9,1);
iter1 = zeros(9,1);
iter2 = zeros(9,1);

for p = 2:10
    pert = 1;
    i = 0;
    X = X0;
    tic;
    while (pert > tol) && (i < maxiter)
        X = (Q - A'*X*A)^(1/p);
        
        pert = norm(X^p + A'*X*A - Q);
        i = i + 1;
    end
    time1(p - 1) = toc;
    iter1(p - 1) = i;
    
    pert = 1;
    i = 0;
    X = X0;
    tic;
    while (pert > tol) && (i < maxiter)
        X = (1/p)*((p-1)*X + (Q - A'*X*A)*X^(1-p));
        
        pert = norm(X^p + A'*X*A - Q);
        i = i + 1;
    end
    time2(p - 1) = toc;
    iter2(p - 1) = i;
end