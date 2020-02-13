function D = Poly(X,n,A,B,C)

if nargin < 5
    disp('Input every coefficient matrix and X0. (by P)');
    return
end

nA = size(A);
nB = size(B);
nC = size(C);
nX0 = size(X);

if ~((nA(1)==nA(2))&(nB(1)==nB(2))&(nC(1)==nC(2))&(nX0(1)==nX0(2)))         % Are they square matrices?
    disp('There is a non-square matrix in A, B, C and X0. (by Q)');
    return
elseif ~((nA(1)==nB(1))&(nB(1)==nC(1))&(nC(1)==nX0(1)))                     % Are the size of matrices same?
    disp('The size of A,B,C and X0 are not same. (by Q)');
    return
else
    D = A*X^n - B*X + C;
end

end