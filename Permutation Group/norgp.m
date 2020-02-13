%====================================
% Generating ����Ƚ���� ���Խô�
%====================================
function XY = norgp(A)
    % ������ �� �������� �ʱ�ȭ ===========================================
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
    er=1; % ��� �߰� �ε���
    re=0; % ��� �߰� ������
    qw=0; % while ������
    op=0; % �н� ������
    % Normalize ==========================================================
    for i=2:Ak
        while qw==0
            qw=1;
            % Conjugate Generating
            for j=1:Ak
                C=A(:,:,j)*B(:,:,er,i)*A(:,:,j)';
                for k=1:er % Conjugate�� �������� Ȯ��
%                    fprintf('1');
                    if B(:,:,k,i)==C
                        re=1;
                        break;
                        
                    end
                end
                
                if re==0 % Conjugate �߰�
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
                    for l=1:er % ������ �������� Ȯ��
%                        fprintf('2');
                        if B(:,:,l,i)==C
                            re=1;
                            break;
                            
                        end
                    end
%                    fprintf('\n');
                    if re==0 % ���� ��� �߰�
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
    op=0;op2=0; % �н� ������
    ui=0; % �׵�� ������
    
    % ��ü�׷� ���� �۾�
    for i=2:Bk
        if B(:,:,Bk,i)==zeros(Bm)
            
        else
            B(:,:,1,i)=zeros(Bm);
        end
    end
    
    % ���� Normal subgroup �з�
    for i=2:Bk % i��° �׷�
        for j=i+1:Bk % j��° �׷�
            op2=0;
            if B(:,:,1,i)==zeros(Bm)
                op2=1;
            end
            if (i~=j & op2==0)
                for k=1:Bk % i��° �׷� k��° ����
                    for l=1:Bk % j��° �׷� l��° ����
                        if B(:,:,k,i)==B(:,:,l,j)
                            ui=ui+1;
                            break;
                        end
                    end
                    
                end

                if ui==Bk % �ߺ��׷� ����
                    B(:,:,1,j)=zeros(Bm);
                end
                ui=0;
            end
        end
    end
    
    % ������ ����׷� �μ�
    fprintf('==============================================================================================\n');
    for i=1:Bk
        xprs(B(:,:,:,i))
        if B(:,:,1,i)==zeros(Bm)
            
        else
            fprintf('==============================================================================================\n');
        end
    end
    
end