i=1;
b=1;
while i>0
    i=0;
    a = b*ones(1,4)
    p = poly([-a, [1 1]])
    for j=1:7
        if (j==6 & p(j)>=0)
            i=i+1;
        elseif (j~=6 & p(j)<=0)
            i=i+1;
        end
    end
    b=b+.01;
end