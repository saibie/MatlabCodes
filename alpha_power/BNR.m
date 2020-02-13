function X = BNR(A,a)
e = 10^(-16);
n = size(A);
n = n(1);
X = eye(n);

if a >= 1
    X = X*A^(floor(a));
    a = a - floor(a);
end

while (norm(A - eye(n),'fro') >= n*e) & (abs(a) > e)
    r = FindBinary(a);
    a = 2^(r)*a - 1;
    for k = 1:r
        A = sqrtm(A);
    end
    X = X*A;
end


end