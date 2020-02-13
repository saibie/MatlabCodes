% make A,B,C for over-damped problem 1
function [A,B,C]=makeABCdampBai(m,a,b);

n=m/2;
A=eye(m,m);

B=zeros(m,m);
for i=1:n;
    for j=1:n;
        if i==j;
            B(i,j)=a;
        else
            B(i,j)=0;
        end
    end
end
for i=n+1:m;
    for j=n+1:m;
        if i==j;
            B(i,j)=b;
        else
            B(i,j)=0;
        end
    end
end
C=zeros(m,m);
C = -diag(ones(m,1)) + diag(ones(m-1,1),1);
C(m,1)=1;
