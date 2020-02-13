clear
n = 3;
X = vpa(rand(n),500);
S = vpa(X + 1e-15*rand(n),500);

W = expm(X/2)*(S - X)*expm(X/2) + expm(X) - expm(S)
double(W)