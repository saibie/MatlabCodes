function S = Poly2nd(X,H,A)

if nargin < 3
    disp('입력값이 모자라다.');
    return
end

nA = size(A);
nX0 = size(X);
nH0 = size(H);

if ~((nA(1)==nA(2))&(nX0(2)==nX0(1))&(nH0(2)==nH0(1))&(nA(1)==nX0(1)))                     % Are the size of matrices right?
    disp('The size of A`s and X0 are not right. (by Polynomial)');
    return
else
    S = zeros(nA(1));
    for i=3:nA(3)
        for j=0:i-3
            for l=i-j-3
                S = S + A(:,:,i)*X^(j)*H*X^l*H*X^(i-j-l-3);
            end
        end
    end
    
    for i=2:nA(3)
        for j=0:i-3
            S = S + A(:,:,i)*X^j*H*X^(i-j-2);
        end
    end
    S = S + Polynom(X,A);
end

end