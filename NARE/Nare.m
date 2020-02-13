function E = Nare(X,C,D,A,B)

if nargin < 5
    disp('Input every coefficient matrix and X0. (by Q)');
    return
end

nA = size(A);
nB = size(B);
nC = size(C);
nD = size(D);
nX0 = size(X);

if ~((nC(1)==nX0(2))&(nC(2)==nX0(1))&(nD(1)==nX0(2))&(nD(2)==nX0(2))&(nA(1)==nX0(1))&(nA(2)==nX0(1))&(nB(1)==nX0(1))&(nB(2)==nX0(2)))                     % Are the size of matrices right?
    disp('The size of A,B,C,D and X0 are not right. (by NARE)');
    return
else
    E = X*C*X - X*D - A*X + B;
end

end