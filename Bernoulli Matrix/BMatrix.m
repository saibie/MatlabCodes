clear
n = 5;
n2 = n^2;
mx = 2^(n^2);
v = nan(mx, n2);
for i = 0:mx - 1
    k = dec2bin(i, n2);
    for j = 1:n2
        v(i+1, j) = str2num(k(j));
    end
end
v = (2*v - 2*(ones(mx, n2) - v))/2;

A = nan(n,n,mx);
for i = 1:mx
    A(:,:,i) = reshape(v(i,:),n,n);
end

NSing = 0;
Sing = 0;
for i = 1:mx
%     A(:,:,i)
    a = det(A(:,:,i));%,pause
    if abs(a) < 1e-15
        Sing = Sing + 1;
    else
        NSing = NSing + 1;
    end
end

p = NSing / (NSing + Sing)
p1 = prod((2.^[1:n-1]-1))./prod((2.^[0:n - 1]))