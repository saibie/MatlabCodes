function Y=xprs(A)
    HK='';
    ML=size(A);
    M=ML(1);L=ML(3); % ������ ����
    if A(:,:,1)==zeros(M) % Normal subgroup �ߺ��׷� �پ�ѱ�
        return
    end
    ST=zeros(2,M); % �ʱ�ȭ
    ER=0;
    qw=0;ui=0;op=0;ty123=0; % ������ �ʱ�ȭ
    AS=1; DF=1;% �ε��� �ʱ�ȭ
    enfg=0;
    for l=1:L
        for j=1:M % ū ������� ����� ====================================
            for i=1:M
                if A(i,j,l)==1
                    ST(1,AS)=j;
                    ST(2,AS)=i;
                    AS=AS+1;
                end
            end
        end % ============================================================

        ER(1)=1;
        for j=1:M
            qw=0;
            asdf=0;
            while (qw==0 & asdf<5)
                for i=1:M
                    if ER(DF)==i
                        qw=1;
                        for ij=1:DF
                            if ER(ij)==ST(2,i)
                                op=1;
                            end                        
                        end
                        if op==0
                            ER(DF+1)=ST(2,i);                        
                        else
                            op=0;
                            ER(DF+1)=.5;
                        end
                        DF=DF+1;
                    end
                end

                if qw==0
                    asdf=asdf+1;
                    for hj=1:M
                        for jh=1:DF
                            if ER(jh)==hj
                                ui=1;
                            end                    
                        end
                        if ui~=1
                            ER(DF+1)=hj;
                            DF=DF+1;
                            asdf=0;
                            break;
                        else
                            ui=0;
                        end
                    end
                end
            end
        end
        
        
        % �׵� �۹����̼� ���� �۾�
        for kl=1:DF-2
            if (ER(kl)==.5 & ER(kl+2)==.5)
                ER(kl+1)=0;
            end
            if ER(2)==.5
                ER(1)=0;
            end
        end
        % ��ȣ ���� �۾�
        for kl=1:DF-2
            if (ER(kl)==0 & ER(kl+1)==.5)
                ER(kl+1)=0;
            end
        end
        

        HK='(';
        for kl=1:DF-1
            if ER(kl)==.5
                HK=[HK ')('];
            elseif ER(kl)~=0
                HK=[HK num2str(ER(kl))];
            end
        end
        HK=[HK ')'];

        SZHK=strfind(HK,'()');
        if A(:,:,l)==zeros(M,M)
            
        else
            if size(HK)==[1 2];
                HK='Identity';
            elseif isempty(SZHK)==0
                HK=HK(1:SZHK-1);
            end
            HK=[HK blanks(15-length(HK))];
            if enfg==5
                fprintf('\n');
                enfg=0;
            end
            fprintf('%s     ',HK);
            enfg=enfg+1;
    %        disp(sprintf('%d %d %d %d %d %d %d',ER));
    %        num2str(A(:,:,l))
        end
        AS=1;DF=1;ER=0;
    end
    fprintf('\n');
end