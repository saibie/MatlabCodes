syms s11 s12 s13 s14 s15 s21 s22 s23 s24 s25 s31 s32 s33 s34 s35 s41 s42 s43 s44 s45 s51 s52 s53 s54 s55
n = 5;
s = [s11 s12 s13 s14 s15; s21 s22 s23 s24 s25; s31 s32 s33 s34 s35; s41 s42 s43 s44 s45; s51 s52 s53 s54 s55];
H = sym(zeros(4,1));

for d=0:n-2
    for j=1:n-d
        for k=j+1:n-d
            H(1) = H(1) + s(d+j,j)*s(d+k,k) + s(d+j,j) + s(d+k,k);
        end
    end
end

%disp(sprintf('phi4'));
for d=-(n-2):-1
    for j=1:n+d
        for k=j+1:n+d
            H(2) = H(2) + s(j,j-d)*s(k,k-d) + s(j,j-d) + s(k,k-d);
        end
    end
end

%disp(sprintf('phi5'));
for d=3:n+1
    for j=1:d-1
        for k=j+1:d-1
            H(3) = H(3) + s(j,d-j)*s(k,d-k) + s(j,d-j) + s(k,d-k);
        end
    end
end

%disp(sprintf('phi6'));
for d=n+2:2*n-1
    for j=d-n:n-1
        for k=j+1:n
            H(4) = H(4) + s(j,d-j)*s(k,d-k) + s(j,d-j) + s(k,d-k);
        end
    end
end

sum(H)