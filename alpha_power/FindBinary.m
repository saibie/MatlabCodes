function r = FindBinary(a)
r = 1;
while a*2^(r) < 1
    r = r + 1;
end

end