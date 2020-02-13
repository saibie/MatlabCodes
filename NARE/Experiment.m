clear A B C D K

for i=1:16
    % Initialize =====================
    D = -.1875*ones(5);
    C = (.25/3)*ones(5,3);
    B = .05*ones(3,5);
    A = -.375*ones(3);
    D = D + .1875*eye(5);
    A = A + .375*eye(3);
    delta = 10^(-i);

    % Delta ==========================
    C = (1 - delta)*C;
    D = ((3 + delta)/3)*D;
    B = ((3 + delta)/3)*B;
    A = (1 - delta)*A;

    D = D + eye(5);
    A = A + eye(3);

    K = [D -C ; -B A];

    [S, XX, H, R_X0, DS, vR, RE, Conv, Conv2, Conv3, Conv4] = NM_NARE(C,D,A,B,zeros(3,5),0);
    T{i} = Conv3;
    
end

semilogy([0:length(T{1})-1],T{1},'-ob');
hold on
semilogy([0:length(T{2})-1],T{2},'--*r');
semilogy([0:length(T{3})-1],T{3},'-.+g');
semilogy([0:length(T{4})-1],T{4},':^m');
semilogy([0:length(T{5})-1],T{5},'-vk');
semilogy([0:length(T{6})-1],T{6},'--<c');
semilogy([0:length(T{7})-1],T{7},'-.>b');
semilogy([0:length(T{8})-1],T{8},':xr');
semilogy([0:length(T{9})-1],T{9},'-sg');
semilogy([0:length(T{10})-1],T{10},'--dm');
semilogy([0:length(T{11})-1],T{11},'-.pk');
semilogy([0:length(T{12})-1],T{12},':hc');
semilogy([0:length(T{13})-1],T{13},'-*b');
semilogy([0:length(T{14})-1],T{14},'--+r');
semilogy([0:length(T{15})-1],T{15},'-.^g');
semilogy([0:length(T{16})-1],T{16},':vm');

l1=legend('$\delta = 10^{-1}$','$\delta = 10^{-2}$','$\delta = 10^{-3}$','$\delta = 10^{-4}$','$\delta = 10^{-5}$','$\delta = 10^{-6}$','$\delta = 10^{-7}$','$\delta = 10^{-8}$','$\delta = 10^{-9}$','$\delta = 10^{-10}$','$\delta = 10^{-11}$','$\delta = 10^{-12}$','$\delta = 10^{-13}$','$\delta = 10^{-14}$','$\delta = 10^{-15}$','$\delta = 10^{-16}$');
set(l1,'Interpreter','Latex');
hold off

