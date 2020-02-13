function A = MakeStochA(m, n)
    A = rand(n+1, m, m);
    b = sum(sum(A,1),2);
    for i = 0:n
        for j = 0:m-1
            A(i+1,j+1,:) = A(i+1,j+1,:)/b(j+1);
        end
    end
    r = max(abs(eig(sum(A,1))));
    
    for i = 0:m-1
        A(2,i+1,i+1) = A(2,i+1,i+1) - r;
    end
    
end