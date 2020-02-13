function [A, B, C] = VibABC(n)
    K = full(gallery('tridiag',n,-10,30,-10));
    K(1,1) = 20;
    K(n,n) = 20;
    K1 = inv(K);
    L = full(gallery('tridiag',n,-5,15,-5));
    
    A = K1;
    B = K1*L;
    C = K1*L;
    
end

