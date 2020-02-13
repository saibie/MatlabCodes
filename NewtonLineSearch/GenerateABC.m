function [A, B, C] = GenerateABC(m, delta)
%GENERATEABC �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
    A = zeros(m,m);
    B = A;
    C = A;
    A = StoRand(m, delta) / 3;
    B = StoRand(m, delta) / 3 - eye(m);
    C = StoRand(m, delta) / 3;
    
end

