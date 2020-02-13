function XYZ=scyclic(A)
    %clear A;
    %A=input('Cycle하고 싶은 Permutation matrix를 입력해 주세요 : ');
    M=size(A);
    if M(1)~=M(2)
        disp('Square matrix를 입력하셔야 합니다.');
        return
    end

    if det(A)==0
        disp('잘못 입력하셨군요. Permutation matrix는 invertible입니다.');
        return
    end

    xi=0;
    for i=1:M(1);for j=1:M(1)
        xi=xi+(A(i,j)~=1 & A(i,j)~=0);
    end;end
    if xi>0
       disp('잘못 입력하셨군요. Permutation matrix는 성분이 0 또는 1입니다.');
       return
    end

    S=sum(sum(A));
    if S~=M(1)
       disp('잘못 입력하셨군요. Permutation matrix가 아닙니다.');
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