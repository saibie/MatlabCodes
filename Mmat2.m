II = 1;
It = 0;
while II > 0
    It = It + 1;
    II = 0;
    %N = rand(2)*5;
    N = [0 1 ; 1 0];
    %M = rand(2)*5;
    M = [0 1 ; 1 0];
    r = max(abs(eig(N)));
    s = max(abs(eig(M)));
    A = r*eye(2) - N;
    B = s*eye(2) - M;
    C = A*B;
    for i=1:2
        for j=1:2
            if i~=j
                II = II+(C(i,j)>=0);
            end
        end
    end
end
rC = max(diag(C))
NC = rC*eye(2) - C
rNC = abs(eig(NC))
rC - max(rNC)