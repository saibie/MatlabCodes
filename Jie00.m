clear
m = 5;
alpha = .2;

A = zeros(m);
for i = 1:m
    for j=i:m
        A(i,j) = i^2 + j;
    end

    s1 = sum(A(i,1:i-1));
    s2 = sum(A(i,1:m));disp(sprintf('(%d,%d),%d',i,j,s2));
    for j=i:m
        A(i,j) = A(i,j)*(1/2 - alpha - s1)/(s2);
        A(j,i) = A(i,j);
    end
end

