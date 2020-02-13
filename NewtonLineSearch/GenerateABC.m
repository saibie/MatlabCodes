function [A, B, C] = GenerateABC(m, delta)
%GENERATEABC 이 함수의 요약 설명 위치
%   자세한 설명 위치
    A = zeros(m,m);
    B = A;
    C = A;
    A = StoRand(m, delta) / 3;
    B = StoRand(m, delta) / 3 - eye(m);
    C = StoRand(m, delta) / 3;
    
end

