function m = fact(n)

if n > 1
    m = n*fact(n-1);
elseif n == 1
    m = 1;
end
end