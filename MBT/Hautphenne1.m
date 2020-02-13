clear


for delta = .85+5*10.^(-[1:8])%.8499:.000001:.8501
    D0 = 10^(-3)*[0 6 0 0 0 0 0 0 0;
                  0 0 6 0 0 0 0 0 0;
                  0 0 0 6 0 0 0 0 0;
                  6 0 0 0 1 1 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 6 0 0;
                  0 0 0 0 0 0 0 6 0;
                  0 0 0 0 0 0 0 0 6;
                  1 0 0 0 1 6 0 0 0];
    D1 = 10^(-2)*diag([delta delta delta delta 5 4 4 4 4]);
    d = [0 0 0 0 1 0 0 0 0]';
    P1 = [eye(4),zeros(4,1),zeros(4);
          [.1 0 0 0],.9,zeros(1,4);
          zeros(4),ones(4,1),zeros(4)];
    P0 = [zeros(4),ones(4,1),zeros(4);
          [.1 0 0 0],.9,zeros(1,4);
          zeros(4),zeros(4,1),eye(4)];
    DD = -(D0*ones(9,1) + D1*ones(9,1) + d);
    D0 = D0 + diag(DD);

    R = zeros(9,81);
    for i=1:9
        for j=1:9
            for k=1:9
                R(i,9*(j-1)+k) = D1(i,i)*P1(i,j)*P0(i,k);
            end
        end
    end

    a = -D0\d;
    B = -D0\R;
    M = B*(kron(eye(9),ones(9,1)) + kron(ones(9,1),eye(9)));
    eM = max(abs(eig(M)));




    [s, Time, i, x, h, f1_x0, f1_s, Conv, Conv2, Conv3, Conv4] = NM_MBT(a,B);s
    [s1, Time, i, x, h, f1_x0, f1_s, Conv, Conv2, Conv31, Conv4] = NM_MBTRelax(a,B);
    xlabel(sprintf('eM = %1.10f,  delta = %1.7f',eM,delta));xlim([0 25]);ylim([10^(-9) 1]);pause(.5);hold off

end