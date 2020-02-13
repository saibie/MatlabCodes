function Compare(A,Q,p)


m=length(A);
X0=eye(m);
[S, iter, res, t] = Jiepthroot4(A,Q,X0,p,1);
[V D] = eig(S);
s=min(eig(S))
a=norm(A,2)
d=(s^p-((a^2)/p)^(p/(p-1)))/(a^2)
% 
% for i=-5:0.1:5;
%     for j=-5:0.1:5;
%         Y0=[i,0;0,j];
%         Y=V*(D+Y0)/V;
%         [Z, iter, res, t] = Jiepthroot4(A,Q,Y,p,1);
%         if iter<90
%         if norm(S-Z)<1e-14;
%             plot(i,j,'y*');
%         else 
%             plot(i,j,'*');
%         end
%         else
%             plot(i,j,'r*');
%         end
%     end
% end
% 
% for i=-5:0.01:5;
%     for j=-5:0.01:5;
%         Y0=[i,0;0,j];
%         Y=V*(D+Y0)/V;
%         if (d-0.15)<norm(Y-V*D/V,2) && norm(Y-V*D/V,'fro')<d
%             plot(i,j,'-')
%         end
%     end
% end
