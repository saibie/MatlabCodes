%====================================
% 처음부터 다시 천천히 만들어 내야겠음
%====================================
function XY = norgpn(A)
    % 연산자 및 변수들의 초기화 ===========================================
    As=size(A);
    Ass=size(As);
    if Ass(2)==3
        Ak=As(3);
    else
        Ak=1;
    end
    Am=As(1);An=As(2);
    Bm=Am;Bn=An;Bk=Ak;Bl=Ak;
    B=zeros(Bm,Bn,Bk,Bl);
    for i=1:Ak
        B(:,:,1,i)=A(:,:,i);
    end
    er=1; % 행렬 추가 인덱스
    re=0; % 행렬 추가 연산자
    qw=0; % while 연산자
    
    % Normalize ==========================================================
    for i=2:Ak
        while qw==0
            qw=1;
            % Conjugate Generating
            for j=1:Ak
                C=A(:,:,j)*B(:,:,er,i)*A(:,:,j)';
                for k=1:er % Conjugate가 닫히는지 확인
                    if B(:,:,k,i)==C
                        re=1;
                        %fprintf('re1=%d\n',re)
                        %pause
                    end
                end
                
                if re==0 % Conjugate 추가
                    B(:,:,er+1,i)=C;
                    er=er+1;
                    qw=0;
                end
                re=0;
            end
            
            % Multiplication Generating
            erer=er;
            for j=1:erer
                for k=1:erer
                    C=B(:,:,j,i)*B(:,:,k,i);
                    for l=1:er % 연산이 닫히는지 확인
                        if B(:,:,l,i)==C
                            re=1;
                            %fprintf('re2=%d\n',re)
                            %pause
                        end
                    end

                    if re==0 % 연산 결과 추가
                        B(:,:,er+1,i)=C;
                        er=er+1;
                        qw=0;
                    end
                    re=0;
                end
            end
            % 항등여부 조사
            %fprintf('qw=%d\n',qw)
        end
        er=1;
        qw=0;
    end
    % ====================================================================
    % 전체그룹 제외 작업
    for i=2:Bk
        if B(:,:,Bk,i)==zeros(Bm)
            
        else
            B(:,:,1,i)=zeros(Bm);
        end
    end

    % 그룹 축소 작업
    D=B;
    clear B;
    ty=0;
    for i=1:Bk
        if D(:,:,1,i)==zeros(Bm)
            
        else
            ty=ty+1;
            B(:,:,:,ty)=D(:,:,:,i);
        end
    end
    
    op=0;op2=0; % 패스 연산자
    ui=0; % 항등여부 연산자
    % 동일 Normal subgroup 분류
    for i=2:ty % i번째 그룹
        for j=2:ty % j번째 그룹
            op2=0;
            if B(:,:,1,i)==zeros(Bm)
                op2=1;
            end
            if (i~=j & op2==0)
                for k=1:Bk % i번째 그룹 k번째 원소
                    for l=1:Bk % j번째 그룹 l번째 원소
                        if (B(:,:,k,i)==B(:,:,l,j) & op==0)
                            ui=ui+1;
                            op=1;
                        end
                    end
                    op=0;
                end

                if ui==Bk % 중복그룹 무시
                    B(:,:,1,j)=zeros(Bm);
                end
                ui=0;
            end
        end
    end
    
    % 마지막 서브그룹 인쇄
    fprintf('==============================================================================================\n');
    for i=1:ty
        xprs(B(:,:,:,i))
        if B(:,:,1,i)==zeros(Bm)
            
        else
            fprintf('==============================================================================================\n');
        end
    end
    
end