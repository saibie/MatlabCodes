clear
n = 4;
n2 = n^2;
mx = 2^(n^2);
v = nan(1, n2);

NSing = 0;
Sing = 0;

b = nan(mx,1);
for i = 0:mx - 1
    k = dec2bin(i, n2);
    for j = 1:n2
        v(j) = str2num(k(j));
    end
    v = (2*v - 2*(ones(1, n2) - v))/2;
    A = reshape(v,n,n);
    
    a = det(A);%,pause
    b(i+1) = a;
    if abs(a) < 1e-15
        Sing = Sing + 1;
    else
        NSing = NSing + 1;
        A,pause
    end
    if mod(i,500) == 0
        disp(sprintf('NSing : %d, Sing : %d',NSing, Sing));
    end
end

p = NSing / (NSing + Sing)
p1 = prod((2.^[1:n-1]-1))./prod((2.^[0:n - 1]))