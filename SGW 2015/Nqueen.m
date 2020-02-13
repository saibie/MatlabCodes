function S = Nqueen(n)
p = perms(1:n);
I = eye(n);
phi = 1;
S = zeros(n);
s = 0;

for al = 1:factorial(n)
    
    x = I(:,p(al,:));
    phi = 0;

%     for i=1:n
%         for j=1:n-1
%             for k=j+1:n
%                 phi = phi + ~(~x(i,j) | ~x(i,k));
%                 phi = phi + ~(~x(j,i) | ~x(k,i));
%             end
%         end
%     end

%     %disp(sprintf('phi3'));
%     for d=0:n-2
%         for j=1:n-d
%             for k=j+1:n-d
%                 phi = phi + ~(~x(d+j,j) | ~x(d+k,k));
%             end
%         end
%     end
% 
%     %disp(sprintf('phi4'));
%     for d=-(n-2):-1
%         for j=1:n+d
%             for k=j+1:n+d
%                 phi = phi + ~(~x(j,j-d) | ~x(k,k-d));
%             end
%         end
%     end
% 
%     %disp(sprintf('phi5'));
%     for d=3:n+1
%         for j=1:d-1
%             for k=j+1:d-1
%                 phi = phi + ~(~x(j,d-j) | ~x(k,d-k));
%             end
%         end
%     end
% 
%     %disp(sprintf('phi6'));
%     for d=n+2:2*n-1
%         for j=d-n:n-1
%             for k=j+1:n
%                 phi = phi + ~(~x(j,d-j) | ~x(k,d-k));
%             end
%         end
%     end

    for k=1:n-1
        for i=1:n-k
            for j=1:n-k
                phi = phi + ~(~x(i,j)|~x(i+k,j+k)) + ~(~x(i,j+k)|~x(i+k,j));
                if phi > 0
                    break;
                end
            end
            if phi > 0
                break;
            end
        end
        if phi > 0
            break;
        end
    end
    
    if phi == 0
        s = s + 1;
        S(:,:,s) = x;
    end
end

if s == 0
    disp(sprintf('Kai Nashi'));
    S = nan;
end
