function [A,B,C,D]=rMmat(m,n,delta)
W=ceil(5*rand(m+n));

% for i=1:m+n
%     W(i,i)=0;
% end

w=sum(W,2);
I=eye(m+n);
% for i=1:m+n
%     W(i,:)=W(i,:)/w(i);
% end

r = ceil(max(abs(eig(W))) + delta);
W = r*I - W;

A = -W(1:n,n+1:n+m);
B = -W(n+1:n+m,n+1:n+m);
C = -W(1:n,1:n);
D = -W(n+1:n+m,1:n);

end