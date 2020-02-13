II = 1;
It = 0;
while II > 0
    It = It + 1;
    II = 0;
    N = rand(5)*5;
    M = rand(5)*5;
%     for i=3:5
%         for j=1:2
%             N(i,j)=0;
%             M(i,j)=0;
%         end
%     end
    r = max(abs(eig(N)));
    s = max(abs(eig(M)));
    A = r*eye(5) - N;
    B = s*eye(5) - M;
    C = A*B;
    for i=1:5
        for j=1:5
            if i~=j
                II = II+(C(i,j)>=0);
            end
        end
    end
end
rC = max(diag(C))
NC = rC*eye(5) - C
rNC = abs(eig(NC))
rC - max(rNC)