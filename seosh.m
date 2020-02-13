function P = seosh(n)
%    n = input('Type the size of the permutation matrix P : ');
    P = zeros(n^2);
    for i=1:n
        for j=1:n
            P(j+(i-1)*n ,i+(j-1)*n) = 1;
        end
    end
end