clear
sigma = 54.461;
sigman = 17.2221;
rx = .5;
ry = .5;

m = 240;
n = 256;

A = -sigman/sigma * ImageRes(ry,m);
B = sigman/sigma * ImageRes(rx,n);
C = rand(m,n);
