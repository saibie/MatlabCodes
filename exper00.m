function [T,eDS] = exper00(n)
for i=1:8
    [A,B,C]=rstochas0(n,10^(-i));
    [S, XX, H, D_X0, DS, vQ, RE, Conv, Conv2, Conv3, Conv4] = NM_QME_NG(A,B,C);
    T{i}=Conv4;
    eDS{i} = eig(-DS);
end
i=9;
    [A,B,C]=rstochas0(n,0);
    [S, XX, H, D_X0, DS, vQ, RE, Conv, Conv2, Conv3, Conv4] = NM_QME_NG(A,B,C);
    T{i}=Conv4;
    eDS{i} = eig(-DS);

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
semilogy(T{9},'-.dg','LineWidth',2, 'MarkerEdgeColor','k', 'MarkerSize',10) % 'MarkerFaceColor','r',
t1 = title('log$({||Q(X_{i+1})||})$');
set(t1,'Interpreter','Latex');
xlabel('Iteration Number')
l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$','$\delta = 0$');
set(l1,'Interpreter','Latex');
    
end