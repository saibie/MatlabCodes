clear
load('CDAB.mat');
syms x;
a = solve(x^2 + 18*x + 1 == 0,x);
a = a(2);
SS = diag([1 a a a a]);
TT = sym([ones(5,1),[-ones(1,4);eye(4)]]);
S2 = TT*SS/TT;
S1 = double(S2);

[S, XX, H, R_X0, DS, vR, RE, Conv, Conv2, Conv3, Conv4] = NM_NARE(C,D,A,B,zeros(5),0);
XXsize = size(XX);
for i=1:XXsize(2)
    G(i) = norm(XX{i} - S1,'fro') / norm(S1,'fro');
end

semilogy([0:length(G)-1],G,'-o')
t = title('log$({||X_{i}-S||}~ /~ {||S||})$');
set(t,'Interpreter','Latex');
