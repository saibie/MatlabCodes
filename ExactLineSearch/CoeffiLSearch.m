function s = CoefficientSearch(A, X, H, jq)
    n = size(A);
    m = n(1);
    n = n(3) - 1;
%     S = zeros(m);
    s = 0;
    for ss = [max([jq - n, 0]):min([jq, n])]
        for rr = ss:n
            for kk = jq-ss:n
                s = s + trace(PHIX(X.', H.', rr, ss) * A(:,:,rr+1).' * A(:,:,kk+1) * PHIX(X, H, kk, jq-ss));                
            end
        end
    end
%     for p = 0:n
%         for k = 0:n
%             for q = 0:p
%                 for j = 0:k
%                     if j+q == jq
%                         S = S + PHIX(X.', H.', p, q) * A(:,:,p+1).' * A(:,:,k+1) * PHIX(X, H, k, j);
%                     end
%                 end
%             end
%         end
%     end
%     s = trace(S);
end