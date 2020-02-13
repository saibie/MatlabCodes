function Y=protoxprs(A)
    ML=size(A);
    M=ML(1);L=ML(3); % 사이즈 측정
    ST=zeros(2,M); % 초기화
    qw=0;ui=0;op=0; % 연산자 초기화
    AS=1; % 인덱스 초기화

    for l=1:L
        for j=1:M
            for i=1:M
                if A(i,j,l)==1
                    ST(1,AS)=j;
                    ST(2,AS)=i;
                    AS=AS+1;
                end
            end
        end
        disp(sprintf('┌ %s ┐',num2str(ST(1,:))));
        disp(sprintf('└ %s ┘',num2str(ST(2,:))));
        disp(' ');
        AS=1;
    end
end