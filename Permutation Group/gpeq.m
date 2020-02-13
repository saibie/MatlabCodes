diseq=0; % 연산자 준비
MA=size(A);MB=size(B);
if MA(3)~=MB(3)
    diseq=1;
end
L=MA(3);
n=MA(1); % 사이즈측정
op=0;qw=0; % 연산자 준비

for m=1:L
    for l=1:L
        S=0;
        for i=1:n % 행렬의 항등여부 조사 ==================================
            for j=1:n
                S=S+(A(i,j,m)~=B(i,j,l));
            end
        end %=============================================================
        if S==0
            op=1;
        end
    end
    if op==0
        disp('정의하신 그룹은 서로 같은 그룹이 아닙니다.');
        return
    end
    op=0;
end

disp('정의하신 그룹은 서로 같은 그룹입니다.');
