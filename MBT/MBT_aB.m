function [a B] = MBT_aB(n)
	a = rand(n,1);
    B = rand(n,n^2);
    w = a + B*ones(n^2,1);
    a = a./w;
    for i=1:n^2
        B(:,i) = B(:,i)./w;
    end

end