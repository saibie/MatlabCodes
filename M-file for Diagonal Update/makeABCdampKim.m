% make A,B,C for over-damped problem 1
function [A, B, C]=makeABCdampKim(m);

A = eye(m);
B = zeros(m);
C = zeros(m);
B(1,1) = 20;
B(1,2) = -10;
B(m,m-1) = -10;
B(m,m) = 20;
C(1,1) = 15;
C(1,2) = -5;
C(m,m-1) = -5;
C(m,m) = 15;
for i = 2:m-1;
	B(i,i-1:1:i+1) = [-10 30 -10];
    C(i,i-1:1:i+1) = [-5 15 -5];
end
