function A = MakeGenSingA(dim, degree, delta, ZDiag)
    if nargin < 3
        delta = 0;
    end
    
    if nargin < 4
        ZDiag = 1;
    end
    
    A = zeros(dim, dim, degree+1);
    
    if degree == 2
        A(:,:,1) = genW(dim, delta, ZDiag);
        A(:,:,2) = genW(dim, delta, ZDiag) - 3*eye(dim);
        A(:,:,3) = genW(dim, delta, ZDiag) + 3*delta * eye(dim);
        A = A/ 3;
    elseif degree == 4
        A(:,:,1) = 16*genW(dim, delta, ZDiag);
        A(:,:,2) = 2*genW(dim, delta, ZDiag) - 26*eye(dim);
        A(:,:,3) = genW(dim, delta, ZDiag);
        A(:,:,4) = 6*genW(dim, delta, ZDiag);
        A(:,:,5) = genW(dim, delta, ZDiag) + 26*delta * eye(dim);
        A = A/ 26;
    elseif degree == 6
        A(:,:,1) = 4096*genW(dim, delta, ZDiag);
        A(:,:,2) = 56*genW(dim, delta, ZDiag) - 6200*eye(dim);
        A(:,:,3) = 384*genW(dim, delta, ZDiag);
        A(:,:,4) = 1312*genW(dim, delta, ZDiag);
        A(:,:,5) = 321*genW(dim, delta, ZDiag);
        A(:,:,6) = 30*genW(dim, delta, ZDiag);
        A(:,:,7) = genW(dim, delta, ZDiag) + 6200*delta * eye(dim);
        A = A/ 6200;
    elseif degree == 8
        A(:,:,1) = 2985984*genW(dim, delta, ZDiag);
        A(:,:,2) = 21024*genW(dim, delta, ZDiag) - 4500000*eye(dim);
        A(:,:,3) = 311040*genW(dim, delta, ZDiag);
        A(:,:,4) = 905472*genW(dim, delta, ZDiag);
        A(:,:,5) = 244080*genW(dim, delta, ZDiag);
        A(:,:,6) = 30312*genW(dim, delta, ZDiag);
        A(:,:,7) = 2017*genW(dim, delta, ZDiag);
        A(:,:,8) = 70*genW(dim, delta, ZDiag);
        A(:,:,9) = genW(dim, delta, ZDiag) + 4500000*delta*eye(dim);
        A = A/ 4500000;
    else
        error('degree 2, 4, 6, 8 외에는 준비되지 않았습니다.');
    end
end