function r = CFBU(X,p,m)
n = length(X);
Y = zeros([n n 2*m]);

Y(:,:,2*m) = (p - m)/(2*(2*m-1))*X;
for j = 2*m-1:-1:1
    if mod(j,2) == 0
        k = j/2;
        cj = (p - k)/(2*(2*k-1));
    elseif j == 1
        cj = -p;
    else
        k = (j - 1)/2;
        cj = (-k -p)/(2*(2*k+1));
    end
    
    Y(:,:,j) = (eye(n) + Y(:,:,j+1)) \ (cj*X);
end
r = eye(n) + Y(:,:,1);

end