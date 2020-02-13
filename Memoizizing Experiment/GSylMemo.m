function value = GSylMemo(AA,BB,CC)
persistent A B X i
if isempty(A)
    A = AA;
    B = BB;
    X = CC;
    i = 0;
    GSylMemo(AA,BB,CC);
elseif i < 50
    X = X + A*X*B;
    A = A*A;
    B = B*B;
    i = i + 1;
    GSylMemo(AA,BB,CC);
end

value = X;
end