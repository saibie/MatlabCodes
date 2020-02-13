function s = CoefficientSearch(A, X, H, jq)
    n = size(A);
    m = n(2);
    n = n(1) - 1;
    S = zeros(m);
    for p = 1:n+1
        for k = 1:n+1
            for q = 1:p+1
                for j = 1:k+1
                    if j+q == jq
                        S = S + PHIX(X.', H.', p, q) * A(p+1,:,:)' * A(k+1,:,:) * PHIX(X, H, k, j);
                    end
                end
            end
        end
    end
    s = tr(S);
end