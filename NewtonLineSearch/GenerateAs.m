function A = GenerateAs(m, delta)
%GENERATEABC 이 함수의 요약 설명 위치
%   자세한 설명 위치
    A = zeros(m,m,3);
    A(:,:,1) = StoRand(m, delta) / 3;
    A(:,:,2) = StoRand(m, delta) / 3 - eye(m);
    A(:,:,3) = StoRand(m, delta) / 3;
    
end

