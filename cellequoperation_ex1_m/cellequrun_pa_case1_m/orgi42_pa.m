function dx=orgi(t,x)
dx=zeros(16,1);
vgamma1=0.004*4.1e-5;
valpha1=0.5*7.35e-2;
vbetar=1.35*3.90e-8;
v10r=1.35*1.12e-3;
sigma12=3.98*10.93;
sigma4=0.68*1.94;
sigma21=1.49*156.17;
sigmabeta=0.5*14.02;



vgammam=8.2e-6;

deltagamma=29.12;
v21=4.1e-5;
delta2=537.46;
v4m=5.83e-5;
v42=1.75e-4;
delta4=349.37;
v2117=8.05e-4;
delta21=63.98;
v6m=3.63e-3;
delta6=29.11;
valpham=2.10e-2;

deltaalpha=388.15;
vbetam=5.6e-9;

deltabeta=349.37;
v10m=3.72e-4;

n2r=3;
zeta2=6.86e-8;
delta10=116.48;
v12m=2.65e-4;
zeta10=1.54e-6;
delta12=8.33;
f1=1;
m0=1.5e-3;
sigmamalpha=2.4;
zetaalpha=9.75e-6;

zetabeta=6.77e-12;
sigmamgamma=24;
mum=1;
f2=10;
sigmam10=24;
zetagamma=2.58e-6;

sigma2=1.23;

zeta6=8e-6;
zeta12=4.90e-8;
gamma1=1.83e-1;
gamma2=5.35e-2;
gammar1=6.06e-2;
mu1=1.4;
zeta4=9.70e-9;
gammar2=6.06e-2;
mu2=1.4;

%sigma6=156.17;
sigmambeta=24;
%sigma10=14.02;
zeta21=4.25e-6;
gammar17=6.06e-2;
mu17=1.4;
mur=1.4;
gamma17=3.37e-1;

deltaalphaA6=10;
deltaalphaA=10;
deltaAalpha=0.3;
%vA=500000 * (mod(t,8) == 0);
% if or(t==2-0.1,or(t==6-0.1,or(t==14-0.1,or(t==30-0.1,or(t==38-0.1,or(t==46-0.1,t==54-0.1))))))==1
%     vA=500000;
% else
%     vA=0;
% end
if t==0
    vA=0;
else
if t==2
        vA=250000;
        else if t==6
        vA=250000;
        else if t==14
        vA=250000;
        else vA=250000*(mod(t-14,8)==0);
            end
            end
end

    end
        

dx(1)=vgammam*x(10)+vgamma1*x(12)-deltagamma*x(1);
dx(2)=v21*x(12)-delta2*x(2);
dx(3)=v4m*x(11)+v42*x(13)-delta4*x(3);
dx(4)=v2117*x(14)-delta21*x(4);
dx(5)=v6m*x(10)-delta6*x(5);
dx(6)=valpham*x(10)+valpha1*x(12)-deltaalpha*x(6)-deltaalphaA6*x(6)*x(16);
dx(7)=vbetam*x(11)+vbetar*x(15)-deltabeta*x(7);  
dx(8)=v10m*x(11)+v10r*(1+n2r*(x(1)/(zeta2+x(2))))*x(15)-delta10*x(8);
dx(9)=v12m*(x(10)/(1+x(8)/zeta10))-delta12*x(9);
dx(10)=(f1+sigmamalpha*(x(6)/(zetaalpha+x(6))))*(m0)-sigmambeta*(x(7)/(zetabeta+x(7)))*x(10)+sigmamgamma*(x(1)/(zetagamma+x(1)))*x(11)-mum*x(10);
dx(11)=(f2+sigmam10*(x(8)/(zeta10+x(8))))*(m0)+sigmambeta*(x(7)/(zetabeta+x(7)))*x(10)-sigmamgamma*(x(1)/(zetagamma+x(1)))*x(11)-mum*x(11);
dx(12)=(sigma12*(x(9)/(zeta12+x(9)))*((x(10)+x(11))/(1+x(8)/zeta10))+sigma2*x(12)*(x(2)/(zeta2+x(2))))*(1/(1+x(13)/gamma2))*(1/(1+x(15)/gammar1))-mu1*x(12);
dx(13)=(sigma4*(x(10)+x(11))*(x(3)/(zeta4+x(3))))*(1/(1+x(12)/gamma1))*(1/(1+x(15)/gammar2))-mu2*x(13);
dx(14)=((sigma21*(x(4)/(zeta21+x(4)))+sigma21*(x(5)/(zeta6+x(5))))*(x(7)/(zetabeta+x(7)))*((x(10)+x(11))/((1+x(1)/zetagamma)*(1+x(3)/zeta4))))*(1/(1+x(15)/gammar17))-mu17*x(14);
dx(15)=((sigmabeta*x(7)/(zetabeta+x(7))+sigmabeta*x(8)/(zeta10+x(8)))*(x(2)/(zeta2+x(2)))*((x(10)+x(11))/(1+x(6)/zetaalpha)))*(1/(1+x(14)/gamma17))-mur*x(15);
dx(16)=vA-deltaalphaA*x(6)*x(16)-deltaAalpha*x(16);


