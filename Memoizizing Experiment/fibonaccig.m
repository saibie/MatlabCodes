function value = fibonaccig(n)
if (n == 1)|(n == 2)
    value = 1;
else
    value = fibonaccig(n-2) + fibonaccig(n-1);
end

end