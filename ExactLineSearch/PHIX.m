function S = PHIX(X, H, k, j)
    m = size(X);
    m = m(1);
    if k == 0
        S = eye(m);
    else
        L = cell(2^k,1);
        LL = zeros(2^k, k);
        phi = {X, H};
        S = zeros(m);
        P = eye(m);
        for p = 0:2^k-1
            L{p+1} = dec2bin(p,k);
        end
        for i = 1:2^k
            for ii = 1:k
                LL(i,ii) = str2num(L{i}(ii));
            end
        end
        for l = 1:2^k
            if sum(LL(l,:)) == j
                for i = 1:k
                    P = P * phi{LL(l,i)+1};
                end
                S = S + P;
                P = eye(m);
            end
        end
    end
    
end

