function Y = Polynom_old(X,A)

if nargin < 2
    disp('Input every coefficient matrix and X0. (by Q)');
    return
end

nA = size(A);
nX0 = size(X);

if ~((nA(1)==nA(2))&(nX0(2)==nX0(1))&(nA(1)==nX0(1)))                     % Are the size of matrices right?
    disp('The size of A`s and X0 are not right. (by Polynomial)');
    return
else
    Y = zeros(nA(1));
    for i=1:nA(3)
        Y = Y + A(:,:,i)*X^(i-1);
    end
end

end