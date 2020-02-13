function dydt = SIS_model(t,y,k)
   
   a = k(1);
   b = k(2);
        
   dydt = zeros(2,1);
   dydt(1) = -b*y(1)*y(2);
   dydt(2) = b*y(1)*y(2)-a*y(2);
end
