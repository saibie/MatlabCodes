function W = genW(dim, delta, ZDiag)
    if nargin < 2
        delta = 0;
    end
    
    if nargin < 3
        ZDiag = 1;
    end
    
    K = rand(dim);
    if ZDiag == 1
        for i = 1:dim
            K(i,i) = 0;
        end
    end
    k = sum(K, 2);
    for j = 1:dim
        K(j,:) = K(j,:)/k(j);
    end
    W = (1 - delta) * K;
end
    