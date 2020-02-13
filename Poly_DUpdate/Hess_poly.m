function [A S] = Hess_poly(m, n, delta)
A = zeros(m,m,n+1);
S = zeros(m);
for i=1:n+1
    A(:,:,i) = rand(m);
    for j=3:m
        for k=1:j-2
            A(j,k,i) = 0;
        end
    end
end
S = sum(A,3);
vs = sum(S,2);
I = eye(m);

for i=1:n+1
    A(:,:,i) = diag(vs)\A(:,:,i);
    p = randperm(m);
    P = I(:,p);
    A(:,:,i) = P'*A(:,:,i)*P;
end
S = sum(A,3);


r = max(abs(eig(S))) + delta;

A(:,:,2) = A(:,:,2) - r*eye(m);
A(:,:,1) = A(:,:,1) + delta*I;

end