function y=cellequoperation_ex1(FN,statenum,totalnum,h,initialx)
odefuctionname=FN;
y=zeros(totalnum+1,statenum);
y(1,:)=initialx;
for i = 1:totalnum
   k1 = odefuctionname((i-1)*h,y(i,:));
   k2 = odefuctionname((i-1)*h+h/2,y(i,:)+h*k1'/2);
   k3 = odefuctionname((i-1)*h+h/2,y(i,:)+h*k2'/2);
   k4 = odefuctionname(i*h,y(i,:)+h*k3');
   y(i+1,:) = y(i,:) + h*(k1' + 2*k2' + 2*k3' + k4')/6;
end