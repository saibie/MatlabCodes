clear
m = 5;
n = 3; %fixed

N = nan(m^n,n);

v = [-1 -m 1];
X = kron([1:m]',ones(m^(n-1),1));
Y = kron(ones(m,1),kron([1:m]',ones(m,1)));
Z = kron(ones(m^(n-1),1),[1:m]');
A = N;B = N;C = N;

for i1 = 1:m
    for i2 = 1:m
        for i3 = 1:m
            C((i1-1)*m^2 + (i2-1)*m + i3, :) = [i1,i2,i3];
            for l = 1:m
                for p = 1:m
                    A((i1-1)*m^2 + (l-1)*m + p, :) = [i1,l,p];
                    B((l-1)*m^2 + (i2-1)*m + i3, :) = [l,i2,i3];
                    
                end
                % A Set Start
                pause
                subplot(1,3,1);hold off;plot3(Y,Z,m+1-X,'ko');hold on;plot3(A(:,2),A(:,3),m+1-A(:,1),'ko','MarkerFaceColor','r','MarkerSize',10);view(v);grid on;xlabel('i2');ylabel('i3');zlabel('i1');
                subplot(1,3,2);hold off;plot3(Y,Z,m+1-X,'ko');hold on;plot3(B(:,2),B(:,3),m+1-B(:,1),'ko','MarkerFaceColor','r','MarkerSize',10);view(v);grid on;xlabel('i2');ylabel('i3');zlabel('i1');
                subplot(1,3,3);hold off;plot3(Y,Z,m+1-X,'ko');hold on;plot3(C(:,2),C(:,3),m+1-C(:,1),'ko','MarkerFaceColor','r','MarkerSize',10);view(v);grid on;xlabel('i2');ylabel('i3');zlabel('i1');
                A = N; B = N;
                % A Set End                
            end
            C = N;
        end
        A = N; B = N;
    end
end
    