function K = StoRand(m, delta)
%STORAND 이 함수의 요약 설명 위치
%   자세한 설명 위치
    K = rand(m);
    for i=1:m;K(i,i)=0;end
    kk = sum(K,2);
    for i=1:m
        K(i,:) = K(i,:)./kk(i);
    end
    K = (1 - delta)*K;
end

