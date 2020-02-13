%====================================
% ó������ �ٽ� õõ�� ����� ���߰���
%====================================
function XY = norgpn(A)
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
    
    % Normalize ==========================================================
    for i=2:Ak
        while qw==0
            qw=1;
            % Conjugate Generating
            for j=1:Ak
                C=A(:,:,j)*B(:,:,er,i)*A(:,:,j)';
                for k=1:er % Conjugate�� �������� Ȯ��
                    if B(:,:,k,i)==C
                        re=1;
                        %fprintf('re1=%d\n',re)
                        %pause
                    end
                end
                
                if re==0 % Conjugate �߰�
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
                    for l=1:er % ������ �������� Ȯ��
                        if B(:,:,l,i)==C
                            re=1;
                            %fprintf('re2=%d\n',re)
                            %pause
                        end
                    end

                    if re==0 % ���� ��� �߰�
                        B(:,:,er+1,i)=C;
                        er=er+1;
                        qw=0;
                    end
                    re=0;
                end
            end
            % �׵�� ����
            %fprintf('qw=%d\n',qw)
        end
        er=1;
        qw=0;
    end
    % ====================================================================
    % ��ü�׷� ���� �۾�
    for i=2:Bk
        if B(:,:,Bk,i)==zeros(Bm)
            
        else
            B(:,:,1,i)=zeros(Bm);
        end
    end

    % �׷� ��� �۾�
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
    
    op=0;op2=0; % �н� ������
    ui=0; % �׵�� ������
    % ���� Normal subgroup �з�
    for i=2:ty % i��° �׷�
        for j=2:ty % j��° �׷�
            op2=0;
            if B(:,:,1,i)==zeros(Bm)
                op2=1;
            end
            if (i~=j & op2==0)
                for k=1:Bk % i��° �׷� k��° ����
                    for l=1:Bk % j��° �׷� l��° ����
                        if (B(:,:,k,i)==B(:,:,l,j) & op==0)
                            ui=ui+1;
                            op=1;
                        end
                    end
                    op=0;
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
    for i=1:ty
        xprs(B(:,:,:,i))
        if B(:,:,1,i)==zeros(Bm)
            
        else
            fprintf('==============================================================================================\n');
        end
    end
    
end