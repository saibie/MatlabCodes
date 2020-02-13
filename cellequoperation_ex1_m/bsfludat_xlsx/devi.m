function NLL = devi(tspan,params,data,xf)
  
   tmeasure = 1:100:1101;
   
   [t,y] = ode45(@SIS_model,tspan,xf,[],params);
   
   q = y(tmeasure(1,:),2);
  
   NLL = sum(q - data.*log(q));
end   