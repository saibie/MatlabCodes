% make A,B,C for over-damped problem 1
function [A,B,C]=makeABCdampBai2(m)
A=eye(m);
C=eye(m);

B=4*eye(m);
for i=1:m;
    for j=1:m;
        if i==j+1;
            B(i,j)=-1;
        else if i==j-1;
                B(i,j)=-1;
            end
        end
    end
end
