function A = MakeSingularA(dim, degree, delta)
    if nargin < 3
        delta = 0;
    end
    
    A = zeros(dim, dim, degree+1);
    K = rand(dim);
    for i = 1:dim
        K(i,i) = 0;
    end
    k = sum(K, 2);
    for j = 1:dim
        K(j,:) = K(j,:)/k(j);
    end
    W = (1 - delta) * K;
    
    if degree == 2
        A(:,:,1) = W;
        A(:,:,2) = W - 3*eye(dim);
        A(:,:,3) = W + 3*delta * eye(dim);
        A = A / 3;
    elseif degree == 4
        A(:,:,1) = 16*W;
        A(:,:,2) = 2*W - 26*eye(dim);
        A(:,:,3) = W;
        A(:,:,4) = 6*W;
        A(:,:,5) = W + 26*delta * eye(dim);
        A = A/26;
    elseif degree == 6
        A(:,:,1) = 4096*W;
        A(:,:,2) = 56*W - 6200*eye(dim);
        A(:,:,3) = 384*W;
        A(:,:,4) = 1312*W;
        A(:,:,5) = 321*W;
        A(:,:,6) = 30*W;
        A(:,:,7) = W + 6200*delta * eye(dim);
        A = A/6200;
    elseif degree == 8
        A(:,:,1) = 2985984*W;
        A(:,:,2) = 21024*W - 4500000*eye(dim);
        A(:,:,3) = 311040*W;
        A(:,:,4) = 905472*W;
        A(:,:,5) = 244080*W;
        A(:,:,6) = 30312*W;
        A(:,:,7) = 2017*W;
        A(:,:,8) = 70*W;
        A(:,:,9) = W + 4500000*delta*eye(dim);
        A = A/4500000;
    else
        error('degree 2, 4, 6, 8 외에는 준비되지 않았습니다.');
    end
    
end