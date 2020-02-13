function A = spec_poly(m, n)
A = zeros(m,m,n+1);
S = zeros(m);
for i=1:m
    for j=1:m
        if i==j
            S(i,j) = 0;
        else
            S(i,j) = 1/((n+1)*(m-1));
        end
    end
end

for i=1:n+1
    if i==2
        A(:,:,i) = -eye(m) + S;
    else
        A(:,:,i) = S;
    end
end

% r = max(abs(eig(S))) + delta;
% 
% A(:,:,2) = A(:,:,2) - r*eye(m);

end