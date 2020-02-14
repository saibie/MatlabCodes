function A = MakeStochA(m, n)
    A = rand(m, m, n+1);
    b = sum(sum(A,3),2);
    for i = 0:n
        for j = 0:m-1
            A(j+1,:,i+1) = A(j+1,:,i+1)/b(j+1);
        end
    end
    r = max(abs(eig(sum(A,1))));
    
    for i = 0:m-1
        A(i+1,i+1,2) = A(i+1,i+1,2) - r;
    end
    
end