function [A S] = rand_poly(m, n, delta)
A = zeros(m,m,n+1);
S = zeros(m);
for i=1:n+1
    A(:,:,i) = rand(m);
    S = S + A(:,:,i);
end

r = max(abs(eig(S))) + delta;

A(:,:,2) = A(:,:,2) - r*eye(m);

end