function value = TriMulti(T,R)
n = length(T);

for i = 1:n
    t{i} = diag(T(1:n-i+1,i:n));
    r{i} = diag(R(1:n-i+1,i:n));
end

for i = n:-1:1
    for j = n+1-i:-1:1
        if j == 1
            t{i+j-1} = t{i}(1:n-i-j+2).*r{j}(i:n-j+1);
        else
            t{i+j-1} = t{i+j-1} + t{i}(1:n-i-j+2).*r{j}(i:n-j+1);
        end
    end
end

for i=1:n
    for j=i:n
        value(i,j) = t{j-i+1}(i);
    end
end

end