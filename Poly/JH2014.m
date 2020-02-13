function [A S1] = JH2014(m)
A = zeros(m,m,11);S1=0;
B = rand(m,m,11);for i=1:11;for j=1:m;B(j,j,i)=0;end;end
s = [1 1 .5 .0025 .125 .001 .0005 .0001 .00005 .00001 .00005]';
S = zeros(m);
for i=1:11
    B(:,:,i) = s(i)*B(:,:,i);
    S = S + B(:,:,i);
end

D = diag(sum(S,2));

for i=1:11
    A(:,:,i) = D\B(:,:,i);
    S1 = S1 + A(:,:,i);
end

A(:,:,2) = A(:,:,2) - eye(m);

end