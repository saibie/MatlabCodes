clear
D = 10*eye(3);
D(3,2) = -1;
d = [1 1 9]';
% for p=0:.1:1
    p = .6;
    R = [0 0 0 0 9*(1-p) 0 4.5*p 0 4.5*p;9*p 0 0 0 0 0 0 0 9*(1-p);0 0 0 0 0 0 0 0 0];
    a = D\d;
    B = D\R;
    M = B*(kron(eye(3),ones(3,1)) + kron(ones(3,1),eye(3)));
%     eig(M),pause
    [s, Time, i, x, h, f1_x0, f1_s, Conv, Conv2, Conv3, Conv4] = NM_MBT(a,B);
    [s1, Time, i, x, h, f1_x0, f1_s, Conv, Conv2, Conv31, Conv4] = NM_MBTRelax(a,B);
% end