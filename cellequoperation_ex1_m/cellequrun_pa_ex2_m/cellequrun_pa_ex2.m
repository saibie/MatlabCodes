clear all
clc


x1=2.58e-6*0.01;
x2=6.86e-8;
x3=9.70e-9;
x4=4.25e-6;
x5=8.00e-6*0.07;
x6=9.75e-6*0.69;
x7=6.77e-12*0.44;
x8=1.54e-6*0.49;
x9=4.90e-8;
x10=2.34e-2;
x11=2.50e-2;
x12=4.58e-2*1.5;
x13=1.34e-2*0.78;
x14=3.37e-1*1.5;
x15=6.06e-2*0.29;
%z(16)=107;
x16=107;

z(1)=2.58e-6;

z(2)=6.86e-8;

z(3)=9.70e-9;

z(4)=4.25e-6;

z(5)=8.00e-6;

z(6)=9.75e-6;

z(7)=6.77e-12;

z(8)=1.54e-6;

z(9)=4.90e-8;

z(10)=2.34e-2;

z(11)=2.50e-2;

z(12)=4.58e-2;

z(13)=1.34e-2;

z(14)=3.37e-1;

z(15)=6.06e-2;

% %z(16)=107;
% x16=107;




%initialx=[458,134,606,0.00258,0.000097,0.000000677,0.000000686,0.0000975,0.0000154];
initialx=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16];
%initialx=[2 5];
 
statenum=16;%state number

%time
starttime=0;%시작시간
time=100; %마지막시간
h=0.001;

Total=(time-starttime)/h;%총시간간격
%여기까지 안건들여도됨

%controltimeint=8;
%imp=controltimeint*ones(1,fix(time/controltimeint));%control 시간 간격
%implocation=[6];%control state
%drate=[0.3];%control시 기존대비 비율



u=[3.40840401526221e-09,3.78250009485587e-08,3.90321078484382e-09...
    9.27531584438833e-08,2.72742332838544e-07,4.70643764651929e-05...
    3.94650421635828e-13,6.89127369562814e-08,6.66004609212309e-08...
    0.00218719815673004,0.0188369476917617,0.495839634385668...
    0.00151697543697818,0.00737185972327908,0.000615234771757722];


y =cellequoperation_ex1(@orgi42_pa,statenum,Total,h,initialx);%첫번째 항에 @함수이름 나머지 안고쳐도됨
xaxis=starttime:h:time;

for i=1:15
    D(1,i)=abs((z(i)-u(i))/2);
    MA(1,i)=z(1,i) + D(1,i);
    MI(1,i)=z(1,i) - D(1,i);
    if MI(1,i)<0;
        MI(1,i)=0;
    end
end



for i=1:15
for k=1:94000
     if MA(1,i) > y(k+6000,i)  && y(k+6000,i) > MI(1,i);
            H(k,i)=1;
     end
end
end

