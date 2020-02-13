function Y = rootest(Z,p,q,s)
    Y = 0;
    if nargin < 4
        s = 0
    end
    for j=1:q
        for k=1:j*p
            K = manyrroots(Z,k,j);
            if s ~= 0
                pause
            end
            Y = Y + K(4);
        end
    end
    
end