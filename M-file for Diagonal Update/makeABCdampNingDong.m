% make A,B,C for over-damped problem 1
function [A,B,C]=makeABCdampNingDong(n,a,b);


A=zeros(n,n);
for i=1:n;
    for j=1:n;
        if i+j == n+1;
            A(i,j)=2/a;
        else
            A(i,j)=1/a;
        end
    end
end

B=zeros(n,n);
for i=1:n;
    for j=1:n;
        if i==j;
            B(i,j)=15;
        else if i+1==j;
                B(i,j)=-3;
            else if i==j+n-2;
                    B(i,j)=-3;
                else
                    B(i,j)=-1;
                end
            end
        end
    end
end 

C=zeros(n,n);
for i=1:n;
    for j=1:n;
        if i==j;
            C(i,j)=15/b;
        else
            C(i,j)= -1/b;
        end
    end
end
