clear;
n=3;
delta = 0;
clear A;
W = rand(n);for ii=1:n;W(ii,ii)=0;end;w = diag(sum(W,2));W = w\W;
A(:,:,1) = W/3;
W = rand(n);for ii=1:n;W(ii,ii)=0;end;w = diag(sum(W,2));W = w\W;
A(:,:,2) = W/3 - eye(n);
W = rand(n);for ii=1:n;W(ii,ii)=0;end;w = diag(sum(W,2));W = w\W;
A(:,:,3) = W/3;

[S1, i1, time1] = NewtonPoly1(A);
[S2, i2, time2] = NewtonModified(A);
[S3, i3, time3] = NewtonPoly2(A);
[S, Xs, Ys, nXSs, nYSs, i, time] = NewtonPoly(A);
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))
i1,i2,i3,time1,time2,time3,norm(S1-S2,'fro')
if i1 < i2
    warning('It is a counter example.')
end
SS = S;
for ii = 1:i
    nXSSs(ii) = norm(SS - Xs(:,:,ii),'fro');
    nYSSs(ii) = norm(SS - Ys(:,:,ii),'fro');
    nPXs(ii) = norm(Polynom(Xs(:,:,ii),A),'fro');
    nPYs(ii) = norm(Polynom(Ys(:,:,ii),A),'fro');
end

for ii=1:i;disp(sprintf('%d %.5e %.5e',ii,nXSSs(ii),nYSSs(ii)));end
% for ii=1:i;disp(sprintf('%d %.5e %.5e',ii,nPXs(ii),nPYs(ii)));end