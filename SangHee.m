function T = SangHee(P)
    m = size(P);
    m = m(2);
    dP = diff([P(:,m), P, P(:,1)], 1, 2);
    T = zeros(1, m);
    for i = 1:m
        T(i) = acos(-(dP(:,i)'*dP(:,i+1)) / (norm(dP(:,i), 2)*norm(dP(:,i+1), 2)));
    end
end

