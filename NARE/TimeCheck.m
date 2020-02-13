clear A B C D K t1 t2 Effi

for j = 1:16
    delta = 10^(-j);

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

    for i=1:300
        [~,Time] = Time_NM_NARE(C,D,A,B);
        t1(i,j)=Time;
        [~,Time] = Time_NM_NARE_Relax(C,D,A,B);
        t2(i,j)=Time;
    end
    Effi(j) = sum(t1(:,j))/sum(t2(:,j))
end


