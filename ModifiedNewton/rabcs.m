function A = rabcs(n,delta)
W=((1-delta)/(3*n - 3))*ones(n);
%W=ones(n);
I = eye(n);

for i=1:n
    W(i,i)=0;
    
end

A = zeros(n,n,3);
A(:,:,3) = W;
A(:,:,2) = W - I;
%B = W - (delta+1)*(3*n - 3)*I;
A(:,:,1) = W + delta*I;
end