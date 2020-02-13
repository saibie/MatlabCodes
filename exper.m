function [T,eDS] = exper(n)
for i=1:8
    [A,B,C]=rstochas(n,10^(-i));
    [S, XX, H, D_X0, DS, vQ, RE, Conv, Conv2, Conv3, Conv4] = NM_QME_NG(A,B,C);
    T{i}=Conv3;
    eDS{i} = eig(-DS);
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
t1 = title('log$({||X_{i}-\hat{S}||}~ /~ {||\hat{S}||})$');
set(t1,'Interpreter','Latex');
xlabel('Iteration Number')
l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$');
set(l1,'Interpreter','Latex');
    
end