function [A, S] = MakeOneSingA(dim, degree, delta, ~)
    if nargin < 3
        delta = 0;
    end
    
    
    A = zeros(dim, dim, degree+1);
    W = (1 - delta) * (ones(dim, dim) - eye(dim)) / (dim - 1);
    P = zeros(dim,dim);
    P(:,1) = ones(dim);
    for i = 2:dim
        P(i,i) = -1;
        P(i-1,i) = 1;
    end
    
    if degree == 2
        A(:,:,1) = W;
        A(:,:,2) = W - 3*eye(dim);
        A(:,:,3) = W + 3*delta * eye(dim);
        A =A/ 3;
        
        s1 = (2 - 2*delta) / (2 + 4*delta);
        s2s = roots([(3*dim-2)*delta - 1, delta + 2 - 3*dim, delta - 1]);
        s2a = abs(s2s);
        [~, I] = min(s2a);
        s2 = s2s(I);
        D = s2 * ones(dim,1);
        D(1) = s1;
        S = P * diag(D) / P;
        
    elseif degree == 4
        A(:,:,1) = 16*W;
        A(:,:,2) = 2*W - 26*eye(dim);
        A(:,:,3) = W;
        A(:,:,4) = 6*W;
        A(:,:,5) = W + 26*delta * eye(dim);
        A =A/ 26;
        
        s1s = roots([1+25*delta, 6-6*delta, 1-delta, -24-2*delta, 16-16*delta]);
        s2s = roots([26*dim*delta - 25*delta - 1, 6*delta - 6, delta - 1, 24 + 2*delta - 26*dim, 16*delta - 16]);
        s1a = abs(s1s);
        s2a = abs(s2s);
        [~, I1] = min(s1a);
        [~, I2] = min(s2a);
        s1 = s1s(I1);
        s2 = s2s(I2);
        D = s2 * ones(dim,1);
        D(1) = s1;
        S = P * diag(D) / P;
        
    elseif degree == 6
        A(:,:,1) = 4096*W;
        A(:,:,2) = 56*W - 6200*eye(dim);
        A(:,:,3) = 384*W;
        A(:,:,4) = 1312*W;
        A(:,:,5) = 321*W;
        A(:,:,6) = 30*W;
        A(:,:,7) = W + 6200*delta * eye(dim);
        A =A/ 6200;
        
        s1s = roots([1+6199*delta, 30*(1-delta), 321*(1-delta), 1312*(1-delta), 384*(1-delta), -6144 - 56*delta, 4096*(1-delta)]);
        s2s = roots([6200*dim*delta - 1 - 6199*delta, 30*(delta-1), 321*(delta-1), 1312*(delta-1), 384*(delta-1), 56*delta + 6144 - 6200*dim, 4096*(delta-1)]);
        s1a = abs(s1s);
        s2a = abs(s2s);
        [~, I1] = min(s1a);
        [~, I2] = min(s2a);
        s1 = s1s(I1);
        s2 = s2s(I2);
        D = s2 * ones(dim,1);
        D(1) = s1;
        S = P * diag(D) / P;
        
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
        A =A/ 4500000;
        
        s1s = roots([1+4499999*delta, 70*(1-delta), 2017*(1-delta), 30312*(1-delta), 244080*(1-delta), 905472*(1-delta), 311040*(1-delta), -21024*delta - 4478976, 2985984*(1-delta)]);
        s2s = roots([4500000*dim*delta - 1 - 4499999*delta, 70*(delta-1), 2017*(delta-1), 30312*(delta-1), 244080*(delta-1), 905472*(delta-1), 311040*(delta-1), 4478976 + 21024*delta - 4500000*dim, 2985984*(delta-1)]);
        s1a = abs(s1s);
        s2a = abs(s2s);
        [~, I1] = min(s1a);
        [~, I2] = min(s2a);
        s1 = s1s(I1);
        s2 = s2s(I2);
        D = s2 * ones(dim,1);
        D(1) = s1;
        S = P * diag(D) / P;
        
    else
        error('degree 2, 4, 6, 8 외에는 준비되지 않았습니다.');
    end
end
    