m = 4;
% n = 1;

Z = zeros(m);
A = Z;
B = Z;
C = Z;

for i1 = 1:m
    for i2 = 1:m
        C(i1,i2) = 1;
        for i = 1:m
            A(i1,i) = 1;
            B(i,i2) = 1;
        end
        [A,nan(m,1),B,nan(m,1),C],pause
        A = Z; B = Z; C = Z;
    end
end
    