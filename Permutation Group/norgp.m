%====================================
% Generating 연산횟수를 줄입시다
%====================================
function XY = norgp(A)
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
    op=0; % 패스 연산자
    % Normalize ==========================================================
    for i=2:Ak
        while qw==0
            qw=1;
            % Conjugate Generating
            for j=1:Ak
                C=A(:,:,j)*B(:,:,er,i)*A(:,:,j)';
                for k=1:er % Conjugate가 닫히는지 확인
%                    fprintf('1');
                    if B(:,:,k,i)==C
                        re=1;
                        break;
                        
                    end
                end
                
                if re==0 % Conjugate 추가
                    B(:,:,er+1,i)=C;
                    er=er+1;
                    qw=0;
                end
                re=0;
                
                if er>(Bk/2)
                    B(:,:,1,i)=zeros(Bm);
                    qw=1;
                    break;
                end
%                fprintf('\n');
            end
            
            % Multiplication Generating
            erer=er;
            %for j=1:erer
                %for k=1:erer
            j=1;
            while j<=er
                k=j;
                
                if er>(Bk/2)
                    B(:,:,1,i)=zeros(Bm);
                    qw=1;
                    break;
                end
                
                while k<=er
                    C=B(:,:,j,i)*B(:,:,k,i);
                    for l=1:er % 연산이 닫히는지 확인
%                        fprintf('2');
                        if B(:,:,l,i)==C
                            re=1;
                            break;
                            
                        end
                    end
%                    fprintf('\n');
                    if re==0 % 연산 결과 추가
                        B(:,:,er+1,i)=C;
                        er=er+1;
                        qw=0;
                    end
                    re=0;
                    k=k+1;
                end
                j=j+1;
                if er>(Bk/2)
                    B(:,:,1,i)=zeros(Bm);
                    qw=1;
                    break;
                end
            end
            
        end
        er=1;
        qw=0;
    end
    % ====================================================================
    op=0;op2=0; % 패스 연산자
    ui=0; % 항등여부 연산자
    
    % 전체그룹 제외 작업
    for i=2:Bk
        if B(:,:,Bk,i)==zeros(Bm)
            
        else
            B(:,:,1,i)=zeros(Bm);
        end
    end
    
    % 동일 Normal subgroup 분류
    for i=2:Bk % i번째 그룹
        for j=i+1:Bk % j번째 그룹
            op2=0;
            if B(:,:,1,i)==zeros(Bm)
                op2=1;
            end
            if (i~=j & op2==0)
                for k=1:Bk % i번째 그룹 k번째 원소
                    for l=1:Bk % j번째 그룹 l번째 원소
                        if B(:,:,k,i)==B(:,:,l,j)
                            ui=ui+1;
                            break;
                        end
                    end
                    
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
    for i=1:Bk
        xprs(B(:,:,:,i))
        if B(:,:,1,i)==zeros(Bm)
            
        else
            fprintf('==============================================================================================\n');
        end
    end
    
end