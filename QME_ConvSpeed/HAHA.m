clear
x = zeros(100,1);
y = ones(100,1);
for i = 1:99
    x(i+1) = x(i)./2 + 1/2;
    y(i+1) = y(i)./2;
end
