n=8;
delta = 0.000000001;
clear A;
K = rand(n);
for i=1:n;K(i,i)=0;end
kk = sum(K,2);
for i=1:n
    K(i,:) = K(i,:)./kk(i);
end

W = ((1-delta)*K);%/(n-1))*(ones(n) - eye(n))
%W = rand(n);for i=1:n;W(i,i)=0;end;w=sum(W,2);for i=1:n;W(i,:)=W(i,:)/w(i);end
W = W/26;

A(:,:,1)=16.*W;
A(:,:,2)=2.*W-eye(n);
A(:,:,3)=W;
A(:,:,4)=6*W;
A(:,:,5)=W+delta*eye(n);

subplot(1,2,2);
[S2, XX2, H2, P_X02, DS2, vP2, RE2, Conv12, Conv22, Conv32, Conv42] = NM_PolyIn2(A,zeros(n),1);
