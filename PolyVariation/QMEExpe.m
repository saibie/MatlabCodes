clear
load('QmeA.mat');
syms x;
a = solve(x^2 + 13*x + 1 == 0,x);
a = a(2);
SS = diag([1 a a a a]);
TT = sym([ones(5,1),[-ones(1,4);eye(4)]]);
S2 = TT*SS/TT;
S1 = double(S2);

[S, XX, H, P_X0, DS, vP, RE, Conv, Conv2, Conv3, Conv4, PofX] = NM_Poly(A,zeros(5),0);
XXsize = size(XX);
for i=1:XXsize(2)
    G(i) = norm(XX{i} - S1,'fro') / norm(S1,'fro');
end

semilogy([0:length(G)-1],G,'-r^')
t = title('log$({||X_{i}-S||}~ /~ {||S||})$');
set(t,'Interpreter','Latex');
