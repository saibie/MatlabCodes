function S = PHIX(X, H, k, j)
    m = size(X);
    m = m(1);
    if k == 0
        S = eye(m);
    else
        L = cell(2^k);
        LL = zeros(2^k, k);
        phi = {X, H};
        S = zeros(m);
        P = eye(m);
        for p = 1:2^k
            L{p} = dec2bin(p,k);
        end
        for i = 1:2^k
            for j = 1:k
                LL(i,j) = str2num(L{i}(j));
            end
        end
        for l = 1:2^k
            if sum(LL(l,:)) == j
                for i = 1:k
                    P = P * phi{LL(l,i)};
                end
                S = S + P;
                P = eye(m);
            end
        end
    end
    
end

