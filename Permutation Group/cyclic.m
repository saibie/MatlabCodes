A=[1 0 0 0 ; 0 0 1 0 ; 0 0 0 1 ; 0 1 0 0];
A(:,:,2)=[0 0 0 0 ; 0 0 1 0 ; 0 0 0 1 ; 0 1 0 0];
k=1;
n=1;
while k>0
    n=n+1;
    A(:,:,n)=A(:,:,n-1)*A(:,:,1);
    B=A(:,:,1)~=A(:,:,n);
    k=sum(sum(B));
end
A=A(:,:,(1:n-1));
A