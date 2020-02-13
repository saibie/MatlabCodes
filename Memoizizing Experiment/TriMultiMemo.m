function value = TriMultiMemo(T,R)
persistent t r i j n
i
if isempty(t)
    n = length(T);
    for k = 1:n
        t{k} = diag(T(1:n-k+1,k:n));
        r{k} = diag(R(1:n-k+1,k:n));
    end
    i = n;
    j = 1;
end

if j == 1
    t{i+j-1} = t{i}(1:n-i-j+2).*r{j}(i:n-j+1);
else
    t{i+j-1} = t{i+j-1} + t{i}(1:n-i-j+2).*r{j}(i:n-j+1);
end

j = j - 1;
if j == 0
    i = i - 1;
    j = n+1-i;
end

if i > 0
    TriMultiMemo(T,R);
end

for i=1:n
    for j=i:n
        value(i,j) = t{j-i+1}(i);
    end
end

end