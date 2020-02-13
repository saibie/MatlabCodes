function [C, D, A, B] = rand_nare(m, n, delta)

N = rand(m+n);
r = max(abs(eig(N)));
M = (r+delta)*eye(m+n) - N;
D = M(1:n,1:n);
A = M(n+1:m+n,n+1:m+n);
C = -M(1:n,n+1:m+n);
B = -M(n+1:m+n,1:n);


end