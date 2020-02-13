clear a B
delta = 0;

% Initialize =======================
n = 3;
a = ones(2^n,1)/2;
B = (1/2^(2*n+1))*ones(2^n,2^(2*n));

% Delta =============================
a = (1+delta)*a;
B = (1-delta)*B;




[s, Time, i, x, h, f1_x0, f1_s, Conv, Conv2, Conv3, Conv4] = NM_MBT(a,B);
[s1, Time, i, x, h, f1_x0, f1_s, Conv, Conv2, Conv31, Conv4] = NM_MBTRelax(a,B);
