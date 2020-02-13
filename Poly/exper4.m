function [T,eDS] = exper4(m)
for i=1:16
    A = Pmaking4(m,10^(-i));
    [S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4] = NM_Poly(A,zeros(m),0);
    T{i}=Conv3;
    eDS{i} = eig(-DS);
%     eDS(i) = min(abs(eig(-DS)));
end

hold off
semilogy(T{1},'-.ok')
hold on
semilogy(T{2},':*r')
semilogy(T{3},'-+b')
semilogy(T{4},'--vg')
semilogy(T{5},'-.^m')
semilogy(T{6},'-^k')
semilogy(T{7},'-.^r')
semilogy(T{8},'-.vb')
semilogy(T{9},'-.ok')
semilogy(T{10},':*r')
semilogy(T{11},'-+b')
semilogy(T{12},'--vg')
semilogy(T{13},'-.^m')
semilogy(T{14},'-^k')
semilogy(T{15},'-.^r')
semilogy(T{16},'-.vb')
t1 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
set(t1,'Interpreter','Latex');
xlabel('Iteration Number')
l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$','$\delta = 10^{-9}$','$\delta = 10^{-10}$','$\delta = 10^{-11}$','$\delta = 10^{-12}$','$\delta = 10^{-13}$','$\delta = 10^{-14}$','$\delta = 10^{-15}$','$\delta = 10^{-16}$','Location','NorthEastOutside');
set(l1,'Interpreter','Latex');
    
end