function [T,eDS] = exper_sp
for i=1:8
    [S, ST, XX, H, D_X0, DS, vQ, RE, Conv, Conv2, Conv3] = NM_QMEsp_NG(i*3);
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
t1 = title('log$({||X_{i+1}-S||}~ /~ {||S||})$');
set(t1,'Interpreter','Latex');
xlabel('Iteration Number')
l1=legend('$n=3$','$n=6$','$n=9$','$n=12$','$n=15$','$n=18$','$n=21$','$n=24$');
set(l1,'Interpreter','Latex');
    
end