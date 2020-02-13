clear;
n=3;
delta = 0;
clear A;
% ===== Case 1 =====
K = ones(n)-eye(n);
for i=1:n;K(i,i)=0;end

kk = sum(K,2);
for i=1:n
    K(i,:) = K(i,:)./kk(i);
end

R = [1 1 0 ; 1 -1 1 ; 1 0 -1];
r = roots([1 7 1]);
r = r(2);
% SS = R*diag([1 r r])/R;
SS = [(2*r+1)/3,(1-r)/3,(1-r)/3;(1-r)/3,(2*r+1)/3,(1-r)/3;(1-r)/3,(1-r)/3,(2*r+1)/3];

W = ((1-delta)*K);%/(n-1))*(ones(n) - eye(n))
%W = rand(n);for i=1:n;W(i,i)=0;end;w=sum(W,2);for i=1:n;W(i,:)=W(i,:)/w(i);end
%W = W/26;

A(:,:,1)=W;
A(:,:,2)=W-3.*eye(n);
A(:,:,3)=W;

A = A./3;

[S, Xs, Ys, nXSs, nYSs, i, time] = NewtonPoly(A);
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))

P_S = zeros(9);
for kk = 1:2
    for ll = 0:kk-1
        P_S = P_S + kron(SS'^(kk-ll-1),A(:,:,kk+1)*SS^ll);
    end
end
[J K] = eig(P_S);

% ========== X tilde Analysis =============
for ii = 1:i
    nXSSs(ii) = norm(SS - Xs(:,:,ii),'fro');
    nYSSs(ii) = norm(SS - Ys(:,:,ii),'fro');
    nPXs(ii) = norm(Polynom(Xs(:,:,ii),A),'fro');
    nPYs(ii) = norm(Polynom(Ys(:,:,ii),A),'fro');
end

% ========= Projection Analysis =========
PNs = zeros(n,n,i);
PMs = zeros(n,n,i);
nPNs = zeros(i,1);
nPMs = zeros(i,1);
for ii = 1:i
    T = J'*reshape(SS - Xs(:,:,ii),n^2,1);
    PNs(:,:,ii) = reshape(J(:,n^2)*T(n^2),n,n);
    PMs(:,:,ii) = reshape(J(:,1:n^2-1)*T(1:n^2-1),n,n);
    nPNs(ii) = norm(PNs(:,:,ii),'fro');
    nPMs(ii) = norm(PMs(:,:,ii),'fro');
end

% ========== Ratio Analysis ===========
t = roots([1 2 10 -1]);
t = t(3);
RofXs = zeros(i,1);
for ii = 2:i
    RofXs(ii-1) = abs((norm(SS - Xs(:,:,ii-1),'fro')/norm(SS - Xs(:,:,ii),'fro'))-2);
end

% ========== Printing ===============
for ii=1:i;disp(sprintf('%d %.5e %.5e',ii,nXSSs(ii),nYSSs(ii)));end
fprintf('\n\n');
disp(sprintf('No. t            Ratio        P_N          P_M          eP_N        1st Cond.  2nd Cond.  3rd Cond.'))
for ii=1:i;disp(sprintf('%2.0f  %.5e  %.5e  %.5e  %.5e  %.5e  %d           %d           %d',ii-1,t,RofXs(ii),nPNs(ii),nPMs(ii),RofXs(ii)*nPNs(ii),t>RofXs(ii),nPMs(ii)<t*nPNs(ii),nXSSs(ii)>nYSSs(ii)));end

figure(1);
sp1 = subplot(1,3,1);hold off
semilogy([0:i-2],t*ones(i-1,1),'-o');hold on
semilogy([0:i-2],RofXs(1:i-1),'-^');
Leg1 = legend('$t$','$\left|\frac{\|\tilde{X}_{i}\|}{\|\tilde{X}_{i+1}\|}-2\right|$');
set(Leg1,'interpreter','latex');
sp1.YLim(2) = 100;


sp2 = subplot(1,3,2);hold off
semilogy([0:i-2],t*nPNs(1:i-1),'-o');hold on
semilogy([0:i-2],nPMs(1:i-1),'-^');
Leg2 = legend('$t\|\mathbf{P}_{\mathcal{N}}(\tilde{X}_{i})\|$','$\|\mathbf{P}_{\mathcal{M}}(\tilde{X}_{i})\|$');
set(Leg2,'interpreter','latex');


sp3 = subplot(1,3,3);hold off
semilogy([0:i-1],nXSSs(1:i),'-o');hold on
semilogy([0:i-1],nYSSs(1:i),'-^');
Leg3 = legend('$\|X_{i} - S\|$','$\|Y_{i} - S\|$');
set(Leg3,'interpreter','latex');
