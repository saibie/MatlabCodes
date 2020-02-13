function A = Pmaking4(n,delta)

A = zeros(n,n,5);
%W = ((1-sqrt(delta))/(n-1))*(ones(n) - eye(n));
W = rand(n);for i=1:n;W(i,i)=0;end;w=sum(W,2);for i=1:n;W(i,:)=W(i,:)/w(i);end

W = W/26;
A(:,:,1)=16.*W + sqrt(delta)*eye(n);
A(:,:,2)=2.*W - (1+sqrt(delta))*eye(n);
A(:,:,3)=W;
A(:,:,4)=6*W;
A(:,:,5)=W;
%[S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4] = NM_Poly(A,zeros(n));
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))
%S
end