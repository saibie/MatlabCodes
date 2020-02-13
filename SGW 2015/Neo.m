clc;
i=1;
while 1 > 0
    y = rand(1);
    if y > (1/2)
        x = 1;
    else
        x = 0;
    end
    fprintf('%1.0f',x);
    if i>100
        fprintf('\n')
        i = 1;
    else
        i = i+1;
    end
end