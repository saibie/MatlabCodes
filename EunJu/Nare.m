function E = Qu(X,A,B,C,D)

if nargin < 5
    disp('Input every coefficient matrix and X0. (by Q)');
    return
end

nA = size(A);
nB = size(B);
nC = size(C);
nD = size(D);
nX0 = size(X);

if ~((nA(1)==nC(1))&(nB(1)==nA(2))&(nB(1)==nB(2))&(nC(1)==nC(2))&(nC(1)==nD(2))&(nB(1)==nD(1)))         % Are they square matrices?
    disp('The dimensions of coefficients are not agree. (by NARE)');
    return
elseif ~((nA(1)==nX0(2))&(nA(2)==nX0(1)))                     % Are the size of matrices same?
    disp('The dimensions of coefficients and X are not agree. (by NARE)');
    return
else
    E = X*A*X + B*X + X*C + D;
end

end