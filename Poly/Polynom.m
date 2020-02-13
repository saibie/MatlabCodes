function Y = Polynom(X,A)

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
    Y = A(:,:,nA(3));
    for i=nA(3)-1:-1:1
        Y = A(:,:,i) +Y*X;
    end
end

end