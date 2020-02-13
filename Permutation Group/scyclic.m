function XYZ=scyclic(A)
    %clear A;
    %A=input('Cycle�ϰ� ���� Permutation matrix�� �Է��� �ּ��� : ');
    M=size(A);
    if M(1)~=M(2)
        disp('Square matrix�� �Է��ϼž� �մϴ�.');
        return
    end

    if det(A)==0
        disp('�߸� �Է��ϼ̱���. Permutation matrix�� invertible�Դϴ�.');
        return
    end

    xi=0;
    for i=1:M(1);for j=1:M(1)
        xi=xi+(A(i,j)~=1 & A(i,j)~=0);
    end;end
    if xi>0
       disp('�߸� �Է��ϼ̱���. Permutation matrix�� ������ 0 �Ǵ� 1�Դϴ�.');
       return
    end

    S=sum(sum(A));
    if S~=M(1)
       disp('�߸� �Է��ϼ̱���. Permutation matrix�� �ƴմϴ�.');
       return
    end 

    k=1;
    n=1;
    while k>0
        n=n+1;
        A(:,:,n)=A(:,:,n-1)*A(:,:,1);
        B=A(:,:,1)~=A(:,:,n);
        k=sum(sum(B));
    end
    A=A(:,:,(1:n-1));
    xprs(A);
end