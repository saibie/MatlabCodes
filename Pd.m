function D = Pd(X,A)

if nargin < 2
    disp('Input every coefficient matrix and X0. (by Q)');
    return
end

nA = size(A);
nX0 = size(X);

if ~((nA(1)==nA(2))&(nX0(1)==nX0(2)))         % Are they square matrices?
    disp('There is a non-square matrix in A and X0. (by Q)');
    return
elseif ~((nA(1)==nX0(1)))                     % Are the size of matrices same?
    disp('The size of A and X0 are not same. (by Q)');
    return
else
    D = X^2 - A'*X*A;
end

end