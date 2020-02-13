function XYZ=sgp(n)
    %n=input('Sn 그룹을 만들기 위해 n을 정의해 주십시오 : ');
    if n==1
        disp('Identity');
        return
    end
    jkl=0; % 23-31 line. 오더 정렬용
    A=zeros(n,n,factorial(n)); % 초기화
    a=ones(1,n);
    uiop=1; % 행렬 입력 판단 연산자
    for k=1:factorial(n)
        while uiop>0
            fi=0;
            for i=1:n-1 % 중복여부 검사
                for j=i+1:n
                    fi=fi+(a(i)==a(j));
                end
            end
            fi=fi+(a(n)==a(1));
            if fi==0
                for i=1:n
                    A(i,a(i),k)=1;
                end
                uiop=0;
            end
            a(n)=a(n)+1;
            while jkl==0
                jkl=1;
                for i=2:n
                    if a(i)>n
                        a(i-1)=a(i-1)+1;a(i)=1;
                        jkl=0;
                    end
                end
            end
            jkl=0;
        end
        uiop=1;
    end
    fprintf('==============================================================================================\n');
    xprs(A);
    fprintf('==============================================================================================\n');
end