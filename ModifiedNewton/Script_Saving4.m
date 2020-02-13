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

[S1, i1, time1] = NewtonPoly1(A);
[S2, i2, time2] = NewtonModified(A);
[S3, i3, time3] = NewtonPoly2(A);
[S, Xs, Ys, nXSs, nYSs, i, time] = NewtonPoly(A);
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))
i1,i2,i3,time1,time2,time3
if i1 < i2
    warning('It is a counter example.')
end