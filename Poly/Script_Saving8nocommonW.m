n=8;
delta = 0.00000000;
clear A;

AA = 4500000;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,1)=2985984.*W;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,2)=(AA-4478976).*W-AA.*eye(n);
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,3)=311040.*W;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,4)=905472.*W;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,5)=244080.*W;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,6)=30312.*W;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,7)=2017.*W;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,8)=70.*W;
K = rand(n);for i=1:n;K(i,i)=0;end;kk = sum(K,2);for i=1:n;K(i,:) = K(i,:)./kk(i);end
W = ((1-delta)*K);
A(:,:,9)=W+AA*delta*eye(n);

A = A./AA;

[S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4] = NM_Poly(A,zeros(n),1);
[S1, XX1, H1, P_X01, DS1, vP1, RE1, Conv1, Conv21, Conv31, Conv41] = NM_Poly2(A,zeros(n),0);
semilogy([0:length(Conv4)-1],Conv3,'-ob',[0:length(Conv41)-1],Conv31,'-^r')
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))
S