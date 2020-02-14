function X = SHLine(P, m, n)
    if nargin < 3
        n = m;
    end
    
    mn = max(m, n);
    l = size(P);
    l = l(2);
    Pp = [P,P(:,1)];
    
    X = zeros(m, n);
    t = linspace(0,1,mn);
    
    for i = 1:l
        x1 = Pp(1,i);
        x2 = Pp(1,i+1);
        y1 = Pp(2,i);
        y2 = Pp(2,i+1);
        
        x = x1 + (x2 - x1)*t;
        y = y1 + (y2 - y1)*t;
        for j = 1:mn
            X(round(y(j)),round(x(j))) = 1;
        end
    end
    
    X = ~X;
end

