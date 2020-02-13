function [T,eDS,L,Q] = experP(n)
for i=1:16
    [S, XX, H, D_X0, DS, vQ, RE, Conv, Conv2, Conv3, Conv4] = NM_QMEP_NG(n,10^(-i));
    T{i}=Conv3;
    eDS{i} = eig(-DS);
    L{i}=Conv;
    Q{i}=Conv2;
end


figure(1);
hold off
semilogy(T{1},'--ok')
hold on
semilogy(T{2},'--or')
semilogy(T{3},'--ob')
semilogy(T{4},'--og')
semilogy(T{5},'--om')
semilogy(T{6},'--^k')
semilogy(T{7},'--^r')
semilogy(T{8},'--^b')
semilogy(T{9},'--^g')
semilogy(T{10},'--^m')
semilogy(T{11},'--vk')
semilogy(T{12},'--vr')
semilogy(T{13},'--vb')
semilogy(T{14},'--vg')
semilogy(T{15},'--vm')
semilogy(T{16},'-dk')

t1 = title('log$({||X_{i}-S||}~ /~ {||S||})$');
set(t1,'Interpreter','Latex');
xlabel('Iteration Number')
l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$','$\delta = 10^{-9}$','$\delta = 10^{-10}$','$\delta = 10^{-11}$','$\delta = 10^{-12}$','$\delta = 10^{-13}$','$\delta = 10^{-14}$','$\delta = 10^{-15}$','$\delta = 10^{-16}$','Location','NorthEastOutside');
set(l1,'Interpreter','Latex');

figure(2);
hold off
plot(L{1},'--ok')
hold on
plot(L{2},'--or')
plot(L{3},'--ob')
plot(L{4},'--og')
plot(L{5},'--om')
plot(L{6},'--^k')
plot(L{7},'--^r')
plot(L{8},'--^b')
plot(L{9},'--^g')
plot(L{10},'--^m')
plot(L{11},'--vk')
plot(L{12},'--vr')
plot(L{13},'--vb')
plot(L{14},'--vg')
plot(L{15},'--vm')
plot(L{16},'-dk')

t1 = title('${||\tilde{X_{i+1}}||}~ /~ {||\tilde{X_{i}}||}$');
set(t1,'Interpreter','Latex');
xlabel('Iteration Number')
l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$','$\delta = 10^{-9}$','$\delta = 10^{-10}$','$\delta = 10^{-11}$','$\delta = 10^{-12}$','$\delta = 10^{-13}$','$\delta = 10^{-14}$','$\delta = 10^{-15}$','$\delta = 10^{-16}$','Location','NorthEastOutside');
set(l1,'Interpreter','Latex');
    
end