n=8;
delta = 0.1;
clear A;
K = rand(n);
for i=1:n;K(i,i)=0;end
kk = sum(K,2);
for i=1:n
    K(i,:) = K(i,:)./kk(i);
end

W = ((1-delta)*K);%/(n-1))*(ones(n) - eye(n))
%W = rand(n);for i=1:n;W(i,i)=0;end;w=sum(W,2);for i=1:n;W(i,:)=W(i,:)/w(i);end
%W = W/26;

A(:,:,1)=4096.*W;
A(:,:,2)=56.*W-6200.*eye(n);
A(:,:,3)=384.*W;
A(:,:,4)=1312.*W;
A(:,:,5)=321.*W;
A(:,:,6)=30.*W;
A(:,:,7)=W+6200*delta*eye(n);

A = A./6200;

% [S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4] = NM_Poly(A,zeros(n),0);
% [S1, XX1, H1, P_X01, DS1, vP1, RE1, Conv1, Conv21, Conv31, Conv41] = NM_PolyRelax(A,zeros(n),1);
% semilogy([0:length(Conv4)-1],Conv3,'-ob',[0:length(Conv41)-1],Conv31,'-^r')
% %[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))
% S
