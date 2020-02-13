function [T, eDS, L, Q] = poly_figure2(n)
hold off
for p=1:9
    if p == 9
        delta = 0;
    else
        delta = 10^(-p);
    end
    
    
    A(:,:,1)=4096.*(1-delta).*eyerand(n);
    A(:,:,2)=56.*(1-delta).*eyerand(n)-eye(n);
    A(:,:,3)=384.*(1-delta).*eyerand(n);
    A(:,:,4)=1312.*(1-delta).*eyerand(n);
    A(:,:,5)=321.*(1-delta).*eyerand(n);
    A(:,:,6)=30.*(1-delta).*eyerand(n);
    A(:,:,7)=(1-delta).*eyerand(n)+delta*eye(n);
%     sum(-sum(A,3),2)
%     A = A./6200;

    [S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4] = NM_Poly(A,zeros(n),0);
    T{p}=Conv3;
    eDS{p} = eig(-DS);
    L{p}=Conv;
    Q{p}=Conv2;
    
end


figure(1);
hold off
semilogy([0:length(T{1})-1],T{1},'--ok')
hold on
semilogy([0:length(T{2})-1],T{2},'--or')
semilogy([0:length(T{3})-1],T{3},'--ob')
semilogy([0:length(T{4})-1],T{4},'--og')
semilogy([0:length(T{5})-1],T{5},'--om')
semilogy([0:length(T{6})-1],T{6},'--^k')
semilogy([0:length(T{7})-1],T{7},'--^r')
semilogy([0:length(T{8})-1],T{8},'--^b')
%semilogy([0:length(T{9})-1],T{9},'--*m')

t1 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
set(t1,'Interpreter','Latex');
xlabel('Iteration Number')
l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$','$\delta = 0$','Location','NorthEast');
set(l1,'Interpreter','Latex');

% figure(2);
% hold off
% plot(L{1},'--ok')
% hold on
% plot(L{2},'--or')
% plot(L{3},'--ob')
% plot(L{4},'--og')
% plot(L{5},'--om')
% plot(L{6},'--^k')
% plot(L{7},'--^r')
% plot(L{8},'--^b')
% 
% t1 = title('${||\tilde{X_{i+1}}||}~ /~ {||\tilde{X_{i}}||}$');
% set(t1,'Interpreter','Latex');
% xlabel('Iteration Number')
% l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$','Location','NorthEastOutside');
% set(l1,'Interpreter','Latex');


end