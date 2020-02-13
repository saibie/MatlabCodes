% make A,B,C for over-damped problem 1
function [A,B,C]=makeABCdamp3(m,a,b);


A=zeros(m,m);
for i=1:m;
    for j=1:m;
        if i+j-1 == m;
            A(i,j)=2/a;
        else
            A(i,j)=1/a;
        end
    end
end

B=zeros(m,m);
for i=1:m;
    for j=1:m;
        if i==j;
            B(i,j)=15;
        else if i+1==j;
                B(i,j)=-3;
            else if i==j+m-2;
                    B(i,j)=-3;
                else
                    B(i,j)=-1;
                end
            end
        end
    end
end 

C=zeros(m,m);
for i=1:m;
    for j=1:m;
        if i==j;
            C(i,j)=15/b;
        else
            C(i,j)= -1/b;
        end
    end
end
