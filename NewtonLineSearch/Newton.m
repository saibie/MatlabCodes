function [S, Xs, Hs, Vs, eP, eL, eR] = Newton(A, X0, iter, tol)
%NEWTON 이 함수의 요약 설명 위치
%   자세한 설명 위치
    m = size(A);
    m = m(1);
    
    if nargin < 4
        tol = m * 1e-15;
    end
    
    if nargin < 3
        iter = 100;
    end
    
    if nargin < 2
        X0 = zeros(m);
    end
    
    err = 1;
    i = 1;
    I = eye(m);
    Xs{1} = X0;
    
    while ((err > tol) && (i < iter))
        P_X = kron(I, A(:,:,3)*X0 + A(:,:,2)) + kron(X0',A(:,:,1));
        eP{i} = eig(P_X);
        eL{i} = eig(kron(I, A(:,:,3)*X0 + A(:,:,2)));
        eR{i} = eig(kron(X0',A(:,:,1)));
        [V, D] = eig(P_X);
        Vs{i} = V;
        PofX = A(:,:,3)*X0*X0 + A(:,:,2)*X0 + A(:,:,1);
        h = - P_X \ PofX(:);
        H = reshape(h,m,m);
        Hs{i} = H;
        X0 = X0 + H;
        err = norm(A(:,:,3)*X0*X0 + A(:,:,2)*X0 + A(:,:,1),'fro');
        i = i+1;
        Xs{i} = X0;
    end
    S = X0;
end

