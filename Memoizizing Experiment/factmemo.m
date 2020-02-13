function value = factmemo(n)
persistent cachedData
if isempty(cachedData)
    cachedData(1) = 1;
    cachedData(2) = 1;
end
try
    value = cachedData(n);
catch
    %value = fibonacci(n-2) + fibonacci(n-1);
    if length(cachedData) < n-1
        % populate the cache for n-1,n-2; dicard result
        fibonacci(n-1);
    end
    value = cachedData(n-2) + cachedData(n-1);
    cachedData(n) = value;
end
end