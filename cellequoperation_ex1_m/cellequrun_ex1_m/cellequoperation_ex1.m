function x=cellequoperation_ex1(FN,statenum,totalnum,h,initialx)
odefuctionname=FN;
x=zeros(totalnum+1,statenum);
x(1,:)=initialx;
for i = 1:totalnum
   k1 = odefuctionname((i-1)*h,x(i,:));
   k2 = odefuctionname((i-1)*h+h/2,x(i,:)+h*k1'/2);
   k3 = odefuctionname((i-1)*h+h/2,x(i,:)+h*k2'/2);
   k4 = odefuctionname((i-1)*h,x(i,:)+h*k3');
   x(i+1,:) = x(i,:) + h*(k1' + 2*k2' + 2*k3' + k4')/6;
end