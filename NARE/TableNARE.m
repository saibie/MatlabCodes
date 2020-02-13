clear A B C D K pNM rNM

% ax(1) = subplot(1,2,1);
% ax(2) = subplot(1,2,2);

for i=1:16
    delta = 10^(-i);
        % Initialize =====================
    D = -.1875*ones(5);
    C = (.25/3)*ones(5,3);
    B = .05*ones(3,5);
    A = -.375*ones(3);
    D = D + .1875*eye(5);
    A = A + .375*eye(3);

    % Delta ==========================
    C = (1 - delta)*C;
    D = ((3 + delta)/3)*D;
    B = ((3 + delta)/3)*B;
    A = (1 - delta)*A;

    D = D + eye(5);
    A = A + eye(3);

    K = [D -C ; -B A];

    [S, XX, H, R_X0, DS, vR, RE, Conv, Conv2, Conv3, Conv4] = NM_NARE(C,D,A,B,zeros(3,5),0);
    [S, XX1, H, R_X0, DS, vR, RE, Conv, Conv2, Conv31, Conv4] = NM_NARE_Relax(C,D,A,B,zeros(3,5),0);
    
    pNM(i) = length(XX);
    rNM(i) = length(XX1);
    
end

