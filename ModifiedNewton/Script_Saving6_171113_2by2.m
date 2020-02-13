clear;
n=2;
delta = 0;
clear A;
% ===== Case 1 =====
K = ones(n)-eye(n);
for i=1:n;K(i,i)=0;end

kk = sum(K,2);
for i=1:n
    K(i,:) = K(i,:)./kk(i);
end

R = [1 1 ; 1 -1];
r = roots([1 30 321 1312 384 6256 4096]);
r = r(6);
% SS = R*diag([1 r r])/R;
SS = [(r+1)/2,(1-r)/2;(1-r)/2,(r+1)/2];

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

[S, Xs, Ys, nXSs, nYSs, i, time] = NewtonPoly(A);
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))

P_S = zeros(n^2);
for kk = 1:6
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
    PNs(:,:,ii) = reshape(J(:,4)*T(4),n,n);
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
for ii=1:i;disp(sprintf('%2.0f  %.5e  %.5e  %.5e  %.5e  %.5e  %d           %d           %d',ii-1,t,RofXs(ii),nPNs(ii),nPMs(ii),RofXs(ii)*nPNs(ii),t>RofXs(ii),nPMs(ii)<RofXs(ii)*nPNs(ii),nXSSs(ii)>nYSSs(ii)));end

figure(1);
sp1 = subplot(1,3,1);hold off
semilogy([0:i-2],t*ones(i-1,1),'-o');hold on
semilogy([0:i-2],RofXs(1:i-1),'-^');
Leg1 = legend('$t$','$\left|\frac{\|\tilde{X}_{i}\|}{\|\tilde{X}_{i+1}\|}-2\right|$');
set(Leg1,'interpreter','latex');
sp1.YLim(2) = 10;


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

%======= Figure 2 =======
figure(2)
tXs = zeros(n);
for ii=1:i
    tXs(:,:,ii) = SS - Xs(:,:,ii);
    tYs(:,:,ii) = SS - Ys(:,:,ii);
end
s21 = subplot(2,2,1);
% loglog(reshape(tXs(1,1,:),i,1),reshape(tXs(2,1,:),i,1),'-o');
s21q = quiver(reshape(tXs(1,1,1:i-1),i-1,1),reshape(tXs(2,1,1:i-1),i-1,1),reshape(tXs(1,1,2:i) - tXs(1,1,1:i-1),i-1,1),reshape(tXs(2,1,2:i) - tXs(2,1,1:i-1),i-1,1));
s21q.AutoScale = 'off';axis equal
% s31.XScale = 'log';s31.YScale = 'log';
s22 = subplot(2,2,2);
% loglog(reshape(tXs(1,2,:),i,1),reshape(tXs(2,2,:),i,1),'-o');
s22q = quiver(reshape(tXs(1,2,1:i-1),i-1,1),reshape(tXs(2,2,1:i-1),i-1,1),reshape(tXs(1,2,2:i) - tXs(1,2,1:i-1),i-1,1),reshape(tXs(2,2,2:i) - tXs(2,2,1:i-1),i-1,1));
s22q.AutoScale = 'off';axis equal
% s32.XScale = 'log';s32.YScale = 'log';

s23 = subplot(2,2,3);
s23q = quiver(reshape(tXs(1,1,1:i-1),i-1,1),reshape(tXs(2,1,1:i-1),i-1,1),reshape(tYs(1,1,2:i) - tXs(1,1,1:i-1),i-1,1),reshape(tYs(2,1,2:i) - tXs(2,1,1:i-1),i-1,1));
s23q.AutoScale = 'off';axis equal
s24 = subplot(2,2,4);
s24q = quiver(reshape(tXs(1,2,1:i-1),i-1,1),reshape(tXs(2,2,1:i-1),i-1,1),reshape(tYs(1,2,2:i) - tXs(1,2,1:i-1),i-1,1),reshape(tYs(2,2,2:i) - tXs(2,2,1:i-1),i-1,1));
s24q.AutoScale = 'off';axis equal

F2Min = min([s21.XLim(1),s21.YLim(1),s22.XLim(1),s22.YLim(1),s23.XLim(1),s23.YLim(1),s24.XLim(1),s24.YLim(1)]);
F2Max = max([s21.XLim(2),s21.YLim(2),s22.XLim(2),s22.YLim(2),s23.XLim(2),s23.YLim(2),s24.XLim(2),s24.YLim(2)]);
s21.XLim = [F2Min,F2Max];
s21.YLim = [F2Min,F2Max];
s22.XLim = [F2Min,F2Max];
s22.YLim = [F2Min,F2Max];
s23.XLim = [F2Min,F2Max];
s23.YLim = [F2Min,F2Max];
s24.XLim = [F2Min,F2Max];
s24.YLim = [F2Min,F2Max];

%======= Figure 3 ===========
figure(3)
s31 = subplot(1,2,1);
% loglog(reshape(tXs(1,1,:),i,1),reshape(tXs(2,1,:),i,1),'-o');
s31q = quiver(reshape(tXs(1,1,1:i-1),i-1,1),reshape(tXs(2,1,1:i-1),i-1,1),reshape(tXs(1,1,2:i) - tXs(1,1,1:i-1),i-1,1),reshape(tXs(2,1,2:i) - tXs(2,1,1:i-1),i-1,1));
s31q.AutoScale = 'off';
s31.XScale = 'log';s31.YScale = 'log';
s32 = subplot(1,2,2);
% loglog(reshape(tXs(1,2,:),i,1),reshape(tXs(2,2,:),i,1),'-o');
s32q = quiver(reshape(tXs(1,2,1:i-1),i-1,1),reshape(tXs(2,2,1:i-1),i-1,1),reshape(tXs(1,2,2:i) - tXs(1,2,1:i-1),i-1,1),reshape(tXs(2,2,2:i) - tXs(2,2,1:i-1),i-1,1));
s32q.AutoScale = 'off';
s32.XScale = 'log';s32.YScale = 'log';
F3Min = min([s31.XLim(1),s31.YLim(1),s32.XLim(1),s32.YLim(1)]);
s31.XLim(1) = F3Min;
s31.YLim(1) = F3Min;
s32.XLim(1) = F3Min;
s32.YLim(1) = F3Min;