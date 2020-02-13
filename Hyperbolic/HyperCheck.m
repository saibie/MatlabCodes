nn = 10;
Bo = full(gallery('tridiag',nn,-10,30,-10));
Bo(1,1) = 20; Bo(nn,nn) = 20;
C = full(gallery('tridiag',nn,-5,15,-5));

e1 = 2;e0 = 0;
while abs(e0 - e1) >= 1e-16
    e = (e0+e1)/2;
    B = e*Bo;
    fx = []; fn = [];
    for i=1:nn
        for j=1:nn
            if i==j
                if C(i,i) == 0 & B(i,i) ~= 0
                    fx = [fx, inf];
                elseif C(i,i) == 0 & B(i,i) == 0
                    fx = [fx, 0];
                else
                    fx = [fx, B(i,i)/C(i,i)];
                end
            else
                if C(i,j) == 0
                    fn = [fn, inf];
                else
                    fn = [fn, B(i,j)/C(i,j)];
                end
            end
        end
    end
    max(fx)
    min(fn),pause
    if max(fx) <= min(fn)
        e1 = e;
    else
        e0 = e;
    end
end
e