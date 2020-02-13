function X = SchurPade(A,p,m)
n = length(A);
yjboolean = 0;
[Q T] = schur(A);

if T == diag(diag(T))
    X = Q*T^(p)*Q';
    return
end

T0 = T;
k = 0;q = 0;

while 1
    t = norm(T - eye(n),1);
    if t <= 2.79e-1
        q = q + 1;
        if t <= 1.88e-2
            j1 = 3;
        elseif t <= 6.04e-2
            j1 = 4;
        elseif t <= 1.24e-1
            j1 = 5;
        elseif t <= 2.00e-1
            j1 = 6;
        elseif t <= 2.79e-1
            j1 = 7;
        end
        
        if t/2 <= 1.88e-2
            j2 = 3;
        elseif t/2 <= 6.04e-2
            j2 = 4;
        elseif t/2 <= 1.24e-1
            j2 = 5;
        elseif t/2 <= 2.00e-1
            j2 = 6;
        elseif t/2 <= 2.79e-1
            j2 = 7;
        end
        
        if (j1 - j2 <= 1) | (q == 2 & m == j1)
            yjboolean = 1;
            break;
        end
    end
    if yjboolean == 1
        break;
    end
    T = SchurRoot(T);
    k = k + 1;
    
end
U = CFBU(eye(n) - T,p,m);

for i = k:-1:0
    if i < k
        U = U^2;
    end
    for j=1:n
        U(j,j) = T0(j,j)^(p/2^(i));
    end
    T1 = T^(p*2^(k - i));
    for j=1:n-1
        U(j,j+1) = T1(j,j+1);
    end
    
end

X = Q*U*Q';
    


end