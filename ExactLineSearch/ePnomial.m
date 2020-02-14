function Y = ePnomial(X, A)
    n = size(A);
    n = n(3) - 1;
    Y = A(:,:,n+1);
    for i = n:-1:1
        Y = A(:,:,i) + Y .* X;
    end
end