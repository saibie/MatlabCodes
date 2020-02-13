n=5;
clear A;
W = 1/(n-1)*(ones(n) - eye(n));
%W = rand(n);for i=1:n;W(i,i)=0;end;w=sum(W,2);for i=1:n;W(i,:)=W(i,:)/w(i);end

W=W/6;
A(:,:,1)=3.*W;
A(:,:,2)=W-eye(n);
A(:,:,3)=W;
A(:,:,4)=W;
[S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4] = NM_Poly(A,zeros(n));
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));
S