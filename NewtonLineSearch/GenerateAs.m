function A = GenerateAs(m, delta)
%GENERATEABC �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
    A = zeros(m,m,3);
    A(:,:,1) = StoRand(m, delta) / 3;
    A(:,:,2) = StoRand(m, delta) / 3 - eye(m);
    A(:,:,3) = StoRand(m, delta) / 3;
    
end

