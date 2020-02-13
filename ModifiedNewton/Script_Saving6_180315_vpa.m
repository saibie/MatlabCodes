clear;
n=3;
delta = 0;
clear A;
% ===== Case 1 =====
K = vpa(ones(n)-eye(n),100);
for i=1:n;K(i,i)=0;end

kk = sum(K,2);
for i=1:n
    K(i,:) = K(i,:)./kk(i);
end

R = [1 1 0 ; 1 -1 1 ; 1 0 -1];
r = vpa(solve('x^6 + 30*x^5 + 321*x^4 + 1312*x^3 + 384*x^2 + 12456*x + 4096 = 0'),100);
r = r(2);
% SS = R*diag([1 r r])/R;
SS = [(2*r+1)/3,(1-r)/3,(1-r)/3;(1-r)/3,(2*r+1)/3,(1-r)/3;(1-r)/3,(1-r)/3,(2*r+1)/3];

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

[S, Xs, Ys, nXSs, nYSs, i, time] = NewtonPolyvpa(A,vpa(zeros(3),100),3e-16);
%[S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,zeros(n));max(abs(eig(DS)))

P_S = zeros(9);
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
PNs = vpa(zeros(n,n,i),100);
PMs = vpa(zeros(n,n,i),100);
nPNs = vpa(zeros(i,1),100);
nPMs = vpa(zeros(i,1),100);
for ii = 1:i
    T = J'*reshape(SS - Xs(:,:,ii),n^2,1);
    PNs(:,:,ii) = reshape(J(:,1)*T(1),n,n);
    PMs(:,:,ii) = reshape(J(:,2:n^2)*T(2:n^2),n,n);
    nPNs(ii) = norm(PNs(:,:,ii),'fro');
    nPMs(ii) = norm(PMs(:,:,ii),'fro');
end

% ========== Ratio Analysis ===========
t = roots([1 2 10 -1]);
t = t(3);
RofXs = vpa(zeros(i,1),100);
for ii = 2:i
    RofXs(ii-1) = abs((norm(SS - Xs(:,:,ii-1),'fro')/norm(SS - Xs(:,:,ii),'fro'))-2);
end

% ========== Printing ===============
for ii=1:i;disp(sprintf('%d %.5e %.5e',ii,nXSSs(ii),nYSSs(ii)));end
fprintf('\n\n');
disp(sprintf('No. t            Ratio        P_N          P_M          eP_N        1st Cond.  2nd Cond.  3rd Cond.'))
for ii=1:i;disp(sprintf('%2.0f  %.5e  %.5e  %.5e  %.5e  %.5e  %d           %d           %d',ii-1,t,RofXs(ii),nPNs(ii),nPMs(ii),RofXs(ii)*nPNs(ii),t>RofXs(ii),nPMs(ii)<RofXs(ii)*nPNs(ii),nXSSs(ii)>nYSSs(ii)));end

figure(1);
sp1 = subplot(1,1,1);hold off
semilogy([0,i-2],t*ones(2,1),'-o');hold on
semilogy([0:i-2],RofXs(1:i-1),'-^');
Leg1 = legend('$t$','$\left|\frac{\|\tilde{X}_{i}\|}{\|\tilde{X}_{i+1}\|}-2\right|$');
set(Leg1,'interpreter','latex');
sp1.YLim(2) = 1000;
sp1.XLim(2) = ceil(i/5)*5;

figure(2);
sp2 = subplot(1,1,1);hold off
semilogy([0:i-2],t*nPNs(1:i-1),'-o');hold on
semilogy([0:i-2],nPMs(1:i-1),'-^');
Leg2 = legend('$t\|\mathbf{P}_{\mathcal{N}}(\tilde{X}_{i})\|$','$\|\mathbf{P}_{\mathcal{M}}(\tilde{X}_{i})\|$');
set(Leg2,'interpreter','latex');
sp2.YLim(1) = 1e-30;
sp2.XLim(2) = ceil(i/5)*5;

figure(3);
sp3 = subplot(1,1,1);hold off
semilogy([0:i-1],nXSSs(1:i),'-o');hold on
semilogy([0:i-1],nYSSs(1:i),'-^');
Leg3 = legend('$\|X_{i} - S\|$','$\|Y_{i} - S\|$');
set(Leg3,'interpreter','latex');
sp3.XLim(2) = ceil(i/5)*5;
