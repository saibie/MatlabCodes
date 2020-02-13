function M = MBT(x,a,B)
M = B*kron(x,x) - x + a;
end