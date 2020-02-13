function S = Energy_Nqueen(n)
p = perms(1:n);
I = eye(n);
phi = 1;
S = zeros(n);
s = 0;

for al = 1:factorial(n)
    
    x = I(:,p(al,:));
    S(:,:,al) = x;
    x = (x-(1/2)).*2;
    theta = 0;


    for k=1:n-1
        for i=1:n-k
            for j=1:n-k
                theta = theta + x(i,j)*x(i+k,j+k) + x(i,j) + x(i+k,j+k) + x(i+k,j)*x(i,j+k) + x(i+k,j) + x(i,j+k);
                
            end
            
        end
        
    end
    
    s(al) = theta;
    
end

hold off
plot(s);
title(['N = ',num2str(n)]);
ylabel('Energy');
hold on
for i=1:factorial(n)
    if s(i) == -n*(n-1)*(2*n-1)/3
        plot(i,s(i),'or');
    end
end
axis([1 factorial(n) min(s) max(s)])