function y=myfunction(x)
    if 0<x && x<100
        y=x^(3/2);
    elseif x>=100 %&& x<200
        y=x^(3/4)*10^(3/2);
%     elseif x>=200 && x<400
%         y=(x^2)/sqrt(8);
%     elseif x>=400 
%         y=(x^(1/2))*2000*sqrt(2);
    end
    end