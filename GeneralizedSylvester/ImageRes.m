function Rzi = ImageRes(rz, n)

Rzi = eye(n);
for i=1:n-1
    Rzi(i,i+1) = -rz;
    Rzi(i+1,i) = -rz;
end

for i=2:n-1
    Rzi(i,i) = Rzi(i,i) + rz^2;
end

Rzi = 1/((1-rz)*(1+rz))*Rzi;

end

