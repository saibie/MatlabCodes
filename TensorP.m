function C = TensorP(A, B)
%TENSORP 이 함수의 요약 설명 위치
%   자세한 설명 위치
nA = size(A);
nB = size(B);
n = nA(2);

for i1 = 1:n
    for i2 = 1:n
        for i3 = 1:n
            C(i1,i2,i3) = 0;
            for k = 1:n
                C(i1,i2,i3) = C(i1,i2,i3) + A(i1,k,i2)*B(k,i2,i3);
            end
        end
    end
end

end

