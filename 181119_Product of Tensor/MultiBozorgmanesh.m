clear
m = 2;
n = 3; %fixed

N = zeros(m,m,m);

A = N;B = N;C = N;
for i = 1:m
    A(i,i,i) = 1;
end
B = rand(m,m,m);


for i1 = 1:m
    for i2 = 1:m
        for i3 = 1:m
            for l = 1:m
                C(i1,i2,i3) = C(i1,i2,i3) + A(i1,l,i2)*B(l,i2,i3);
            end            
        end        
    end
end

B,C
B==C
A,C
A==C