% disp(sprintf('phi3'));
% for d=0:n-2
%     for j=1:n-d
%         for k=j+1:n-d
%             disp(sprintf('%d : (%d, %d), (%d, %d)',d,d+j,j,d+k,k));
%             y(d+j,j) = 1;y(d+k,k)=1;
%         end
%     end
%     fprintf('\n');
% end
% y
% y = zeros(n);
% 
% disp(sprintf('phi4'));
% for d=-(n-2):-1
%     for j=1:n+d
%         for k=j+1:n+d
%             disp(sprintf('%d : (%d, %d), (%d, %d)',d,j,j-d,k,k-d));
%             y(j,j-d) = 1;y(k,k-d)=1;
%         end
%     end
%     fprintf('\n');
% end
% y
% y = zeros(n);
% 
% disp(sprintf('phi5'));
% for d=3:n+1
%     for j=1:d-1
%         for k=j+1:d-1
%             disp(sprintf('%d : (%d, %d), (%d, %d)',d,j,d-j,k,d-k));
%             y(j,d-j) = 1;y(k,d-k)=1;
%         end
%     end
%     fprintf('\n');
% end
% y
% y = zeros(n);
% 
% disp(sprintf('phi6'));
% for d=n+2:2*n-1
%     for j=d-n:n-1
%         for k=j+1:n
%             disp(sprintf('%d, %d, %d : (%d, %d), (%d, %d)',d,j,k,j,d-j,k,d-k));
%             y(j,d-j) = 1;y(k,d-k)=1;
%         end
%     end
%     fprintf('\n');
% end
% y
% y = zeros(n);
