clear;
n=3;
delta = 0.00;
clear A;

W = zeros(n,n,7);
K = rand(n,n,7);
for kk = 1:7
    for ii = 1:n
        K(ii,ii,kk) = 0;
    end
end

for kk = 1:7
    K(:,:,kk) = diag(sum(K(:,:,kk),2))\K(:,:,kk);
end

R = [1 1 0 ; 1 -1 1 ; 1 0 -1];
r = roots([1 30 321 1312 384 12456 4096]);
r = r(6);
% SS = R*diag([1 r r])/R;
SS = [(2*r+1)/3,(1-r)/3,(1-r)/3;(1-r)/3,(2*r+1)/3,(1-r)/3;(1-r)/3,(1-r)/3,(2*r+1)/3];

for kk = 1:7
    W(:,:,kk) = ((1-delta)*K(:,:,kk));
end

A(:,:,1) = 4096.*W(:,:,1);
A(:,:,2) = 56.*W(:,:,2)-6200.*eye(n);
A(:,:,3) = 384.*W(:,:,3);
A(:,:,4) = 1312.*W(:,:,4);
A(:,:,5) = 321.*W(:,:,5);
A(:,:,6) = 30.*W(:,:,6);
A(:,:,7) = W(:,:,7) + 6200*delta*eye(n);

A = A./6200;

[S, Xs, Ys, nXSs, nYSs, i, time] = NewtonPolyvpa(A);
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
PNs = zeros(n,n,i);
PMs = zeros(n,n,i);
nPNs = zeros(i,1);
nPMs = zeros(i,1);
for ii = 1:i
    T = J'*reshape(S - Xs(:,:,ii),n^2,1);
    PNs(:,:,ii) = reshape(J(:,1)*T(1),n,n);
    PMs(:,:,ii) = reshape(J(:,2:n^2)*T(2:n^2),n,n);
    nPNs(ii) = norm(PNs(:,:,ii),'fro');
    nPMs(ii) = norm(PMs(:,:,ii),'fro');
end

% ========== Ratio Analysis ===========
t = roots([1 2 10 -1]);
t = t(3);
RofXs = zeros(i,1);
for ii = 3:i
    RofXs(ii-1) = abs((norm(Xs(:,:,ii-1) - Xs(:,:,ii-2),'fro')/norm(Xs(:,:,ii) - Xs(:,:,ii-1),'fro'))-2);
end

%========= PMXs, PNXs ============
P_X = zeros(n^2,n^2,i);
dX = zeros(n^2,i);
JX = zeros(n^2,n^2,i);
for ii=1:i
    for kk = 1:6
        for ll = 0:kk-1
            P_X(:,:,ii) = P_X(:,:,ii) + kron(Xs(:,:,ii)'^(kk-ll-1),A(:,:,kk+1)*Xs(:,:,ii)^ll);
        end
    end
    [JX(:,:,ii) DX] = eig(P_X(:,:,ii));
    dX(:,ii) = diag(DX);
end

PNXs = zeros(n,n,i);
PMXs = zeros(n,n,i);
nPNXs = zeros(i,1);
nPMXs = zeros(i,1);
for ii = 2:i
    [m, mindex] = min(abs(dX(:,ii)));
    T = JX(:,:,ii)\reshape(Xs(:,:,ii) - Xs(:,:,ii-1),n^2,1);
    PNXs(:,:,ii) = reshape(JX(:,mindex,ii)*T(mindex),n,n);
    PMXs(:,:,ii) = reshape(JX(:,[1:mindex-1,mindex+1:n^2],ii)*T([1:mindex-1,mindex+1:n^2]),n,n);
    nPNXs(ii) = norm(PNXs(:,:,ii),'fro');
    nPMXs(ii) = norm(PMXs(:,:,ii),'fro');
end


% ========== Printing ===============
for ii=1:i;disp(sprintf('%d %.5e %.5e',ii,nXSs(ii),nYSs(ii)));end
fprintf('\n\n');
disp(sprintf('No. t            Ratio        P_NX         P_MX         eP_N        1st Cond.  2nd Cond.  3rd Cond.'))
for ii=1:i;disp(sprintf('%2.0f  %.5e  %.5e  %.5e  %.5e  %.5e  %d           %d           %d',ii-1,t,RofXs(ii),nPNXs(ii),nPMXs(ii),RofXs(ii)*nPNXs(ii),t>RofXs(ii),nPMXs(ii)<t*nPNXs(ii),nXSs(ii)>nYSs(ii)));end

figure(1);
sp1 = subplot(1,3,1);hold off
semilogy([0:i-2],t*ones(i-1,1),'-o');hold on
semilogy([0:i-2],RofXs(1:i-1),'-^');
Leg1 = legend('$t$','$\left|\frac{\|X_{i} - X_{i-1}\|}{\|X_{i+1} - X_{i}\|}-2\right|$');
set(Leg1,'interpreter','latex');
sp1.YLim(2) = 100;


sp2 = subplot(1,3,2);hold off
semilogy([0:i-2],t*nPNXs(1:i-1),'-o');hold on
semilogy([0:i-2],nPMXs(1:i-1),'-^');
Leg2 = legend('$t\|\mathbf{P}_{\mathcal{N}_{i}}(\tilde{X}_{i})\|$','$\|\mathbf{P}_{\mathcal{M}_{i}}(\tilde{X}_{i})\|$');
set(Leg2,'interpreter','latex');


sp3 = subplot(1,3,3);hold off
semilogy([0:i-1],nXSs(1:i),'-o');hold on
semilogy([0:i-1],nYSs(1:i),'-^');
Leg3 = legend('$\|X_{i} - S\|$','$\|Y_{i} - S\|$');
set(Leg3,'interpreter','latex');

tXs = zeros(n,n,i);
for ii = 1:i
    tXs(:,:,ii) = S - Xs(:,:,ii);
end

inn = zeros(i,1);
for ii = 1:i
    inn(ii) = trace(PNXs(:,:,ii)'*tXs(:,:,ii)) / (norm(tXs(:,:,ii))*norm(PNXs(:,:,ii)));
end

tinn = zeros(i-1,1);
for ii = 1:i-1
    tinn(ii) = trace(tXs(:,:,ii+1)'*tXs(:,:,ii)) / (norm(tXs(:,:,ii))*norm(tXs(:,:,ii+1)));
end
