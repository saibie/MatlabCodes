% make A,-B,C for over-damped problem 1
function [A, B, C]=makeABCdampBoYu(m,a,b);
%m = input('input size');
%A = eye(m); B = zeros(m); C = zeros(m);


%a=-1;b=4+150/((m+1)^2);c=-1;
%T = b*diag(ones(m,1)) + c*diag(ones(m-1,1),1) + a*diag(ones(m-1,1),-1);
n=m^2;
I=eye(m);

A=zeros(n,n);
A = (1/a)*( 2*diag(ones(n,1)) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1));

B=zeros(n,n);
B = (1/b)*( (4+150/((m+1)^2)) * diag(ones(n,1)) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1) - diag(ones(m^2-m,1),m) - diag(ones(m^2-m,1),-m));
for i=1:m-1
    B(m*i+1,m*i)=0;
    B(m*i,m*i+1)=0;    
end

C=zeros(n,n);
C = (1/b)*( (4+150/((m+1)^2))*diag(ones(n,1)) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1));



%B = (1/b)* diag(ones(m^2,1)) + c*diag(ones(m^2-1,1),1) + a*diag(ones(m^2-1,1),-1) - diag(ones(m^2-m,1),m) - diag(ones(m^2-m,1),-m);
%for i=1:m-1
%    B(m*i+1,m*i)=0;

%    B(m*i,m*i+1)=0;    
%end
















%B = b*diag(ones(m^2,1)) + c*diag(ones(m^2-1,1),1) + a*diag(ones(m^2-1,1),-1) - diag(ones(m^2-m,1),m) - diag(ones(m^2-m,1),-m);
%for i=1:m-1
%    B(m*i+1,m*i)=0;
%    B(m*i,m*i+1)=0;    
%end

%a=1;b=2;c=1;
%A =(1/20)*( b*diag(ones(m^2,1)) + c*diag(ones(m^2-1,1),1) + a*diag(ones(m^2-1,1),-1));
%a=-1;b=4+150/((m+1)^2);c=-1;
%C = (1/15)*(b*diag(ones(m^2,1)) + c*diag(ones(m^2-1,1),1) + a*diag(ones(m^2-1,1),-1));



%B(1,1) = 20; B(1,2) = -10;
%B(m,m-1) = -10; B(m,m) = 25;
%C(1,1)=15; C(1,2)=-5;
%C(m,m-1)=-5; C(m,m)=15;
%for i = 2:m-1
%	B(i,i-1:1:i+1) = [-10 30 -10];
%	C(i,i-1:1:i+1) = [-5 15 -5];
%end
	