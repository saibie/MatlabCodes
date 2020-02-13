function X = SchurRoot(A)
n = length(A);
[Q T] = schur(A);
for i = 1:n
    U(i,i) = T(i,i)^(1/2);
end

for j=2:n
    for i=j-1:-1:1
        U(i,j) = T(i,j);
        for k=i+1:j-1
            U(i,j) = U(i,j) - U(i,k)*U(k,j);
        end
        U(i,j) = U(i,j) / (U(i,i) + U(i,j));
    end
end
X = Q*U*Q';

end