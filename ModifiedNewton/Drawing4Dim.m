clear
tol = 2*10^(-16);
A = nan(2,2,5);
B = nan(2,2,5);
% A(:,:,1) = [0 16;16 0]/26;
% A(:,:,2) = [-26 2;2 -26]/26;
% A(:,:,3) = [0 1;1 0]/26;
% A(:,:,4) = [0 6;6 0]/26;
% A(:,:,5) = [0 1;1 0]/26;

for ii=1:2-1                                                                 % Eigenvector Matrix P
    P1(ii,ii)=1;
    P1(ii+1,ii)=-1;
end

P = [ones(2,1) P1];

invP = ones(1,2)/2;                                                         % Inverse of P
for ii=1:2-1
    for j=1:2
        if j>ii
            invP(ii+1,j)= - ii/2;
        else
            invP(ii+1,j)= (2-ii)/2;
        end
    end
end



deltas = .01;
for delta = deltas;



W = ((1-delta)*[0 1 ; 1 0]);
W = W/26;

A(:,:,1)=16.*W;
% W = ((1-delta)*[0 1 ; 1 0]); W = W/26;
A(:,:,2)=2.*W-eye(2);
% W = ((1-delta)*[1/3 2/3 ; 3/5 2/5]); W = W/26;
A(:,:,3)=W;
A(:,:,4)=6*W;
A(:,:,5)=W+delta*eye(2);


for ii=1:5
    B(:,:,ii) = invP*A(:,:,ii)*P;
end
pB1 = shiftdim(B(1,1,5:-1:1));
rB1 = roots(pB1);
rB1 = real(rB1.*(abs(imag(rB1))<10^(-7)));
rB1 = rB1.*~(rB1<0);
rB1 = nonzeros(rB1);
rB1 = min(rB1);
pB2 = shiftdim(B(2,2,5:-1:1));
rB2 = roots(pB2);
rB2 = rB2.*~any(imag(rB2),2);
rB2 = rB2.*~(rB2>0);
rB2 = nonzeros(rB2);
rB2 = max(rB2);
SD = diag([rB1 rB2]);
ST = P*SD*invP;


Xs = nan(2,2,100);
Ys = nan(2,2,100);
Hs = nan(2,2,99);
Xs(:,:,1) = zeros(2);
Ys(:,:,1) = zeros(2);
X0 = zeros(2);
i = 1;
while 1
    P_X0 = zeros(2^2);
    for j=1:4                                                               % P_X
        for k=1:j
            P_X0 = P_X0 + kron(X0'^(j-k),A(:,:,j+1)*X0^(k-1));
        end
    end
    vP = -(Polynom(X0,A));
    vP = vP(:);
    vH = P_X0 \ vP;
    H = reshape(vH,2,2);
    Hs(:,:,i) = H;
    X0 = X0 + H;
    Y0 = X0 + H;
    i = i + 1;
    Xs(:,:,i) = X0;
    Ys(:,:,i) = Y0;
    if norm(Polynom(X0,A),'fro') < tol
        break;
    end
end

Xs = Xs(:,:,1:i);
Ys = Ys(:,:,1:i);
Hs = Hs(:,:,1:i-1);
NuS = Xs(:,:,i);
S = ST;
Ss = [];

P_S = zeros(2^2);
for j=1:4                                                               % P_S
    for k=1:j
        P_S = P_S + kron(S'^(j-k),A(:,:,j+1)*S^(k-1));
    end
end
[X D] = eig(P_S);


for ii=1:i
    Ss = cat(3,Ss,S);
end
Ts = Ss - Xs;
TYs = Ss - Ys;

for ii=1:i
    T = Ts(:,:,ii);
    T = T(:);
    TY = TYs(:,:,ii);
    TY = TY(:);
    Pa = X\T;
    a4(ii) = Pa(4);
    a1a2a3(:,ii) = Pa(1:3);
    PaY = X\TY;
    a4Y(ii) = PaY(4);
    a1a2a3Y(:,ii) = PaY(1:3);
end

% figure(1);
% subplot(1,2,1);compass(shiftdim(Ts(1,1,:)),shiftdim(Ts(2,1,:)));subplot(1,2,2);compass(shiftdim(Ts(1,2,:)),shiftdim(Ts(2,2,:)))
figure(1);
subplot(1,2,1);hold off
for ii=1:length(a4)
    plot(a4(ii),.5,'bo');hold on
    plot(a4Y(ii),-.5,'ro');
    plot([a4(ii),a4Y(ii)],[.5,-.5],'k-');
end
grid on;axis([-1.5 1.5 -1.5 1.5]);
% subplot(1,2,1);semilogy(abs(a4),'o');grid on;hold on;semilogy(abs(a4Y),'ro');hold off;%axis equal;axis([-1.5 1.5 -1.5 1.5])
subplot(1,2,2);plot3(a1a2a3(1,:),a1a2a3(2,:),a1a2a3(3,:),'-o');grid on;hold on;plot3(a1a2a3Y(1,:),a1a2a3Y(2,:),a1a2a3Y(3,:),'-or');hold off;

% figure(2);
% [mina1a2a3 mindex] = min(a1a2a3(:,1));
% a1a2 = a1a2a3([1:mindex-1,mindex+1:3],:);
% a1a2Y = a1a2a3Y([1:mindex-1,mindex+1:3],:);
% plot3(a1a2(1,:),a1a2(2,:),a4,'-o');grid on;hold on;plot3(a1a2Y(1,:),a1a2Y(2,:),a4Y,'-or');hold off;axis equal;

figure(2);
% for ii = [1:5]
%     ax = subplot(1,2,1);
%     plot(ii,a4(ii),'ko');hold on
%     plot(ii,a4(ii+1),'bo');
%     plot(ii,a4Y(ii+1),'ro');
%     plot(-[-1 -5 -5 -1 -1],[-2*10^(-8) -2*10^(-8) 2*10^(-8) 2*10^(-8) -2*10^(-8)],'m-');
%     axm = max(abs(ax.YLim));
%     ax.YLim = [-axm axm];
%     grid on;
% end
% hold off;
for ii = [1:length(a4)-1]
    ax = subplot(2,4,find(deltas==delta));
    plot(ii,a4(ii),'ko');hold on
    plot(ii,a4(ii+1),'bo');
    plot(ii,a4Y(ii+1),'ro');
    plot([length(a4)-5 length(a4)-1 length(a4)-1 length(a4)-5 length(a4)-5],[-2*10^(-8) -2*10^(-8) 2*10^(-8) 2*10^(-8) -2*10^(-8)],'m-');
    axm = max(abs(ax.YLim));
    ax.YLim = [-axm axm];
    grid on;
end
hold off;
figure(3);
% plot3(a1a2(1,length(a4)-5:length(a4)),a1a2(2,length(a4)-5:length(a4)),a4(length(a4)-5:length(a4)),'-o');grid on;hold on;plot3(a1a2Y(1,length(a4)-5:length(a4)),a1a2Y(2,length(a4)-5:length(a4)),a4Y(length(a4)-5:length(a4)),'-or');hold off;axis equal;
% jj = length(a4)-2:length(a4);
jj = [1:length(a4)];
plot3(a1a2a3(1,jj),a1a2a3(2,jj),a1a2a3(3,jj),'-o');grid on;hold on;
for ii = jj(2:end)
    plot3([a1a2a3(1,ii),a1a2a3Y(1,ii)],[a1a2a3(2,ii),a1a2a3Y(2,ii)],[a1a2a3(3,ii),a1a2a3Y(3,ii)],'r-');
    plot3(a1a2a3Y(1,ii),a1a2a3Y(2,ii),a1a2a3Y(3,ii),'or');
end
hold off;axis square

end