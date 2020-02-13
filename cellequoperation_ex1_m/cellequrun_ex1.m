



%Vars=[vgammam, vgamma1, deltagamma, v21, delta2, v4m, v42, delta4, v2117, delta21;
%    v6m, delta6, valpham, valpha1, deltaalpha, vbetam, vbetar, deltabeta, v10m, v10r;
%    n2r, zeta2, delta10, v12m, zeta10, delta12, f1, m0, sigmamalpha, zetaalpha; 
%    sigmambeta, zetabeta, sigmamgamma, mum, f2, sigmam10, zetagamma, sigma12, sigma2, sigma4; 
%    zeta6, zeta12, gamma1, gamma2, gammar1, mu1, zeta4, gammar2, mu2, sigma21; 
%    sigma6, sigmabeta, sigma10, zeta21, gammar17, mu17, mur, gamma17, a, b];


% T1=zeros(Total+1,1); 
% T2=zeros(Total+1,1); 
% Tr=zeros(Total+1,1); 
% Igamma=zeros(Total+1,1); 
% I4=zeros(Total+1,1); 
% Ibeta=zeros(Total+1,1); 
% I2=zeros(Total+1,1); 
% Ialpha=zeros(Total+1,1); 
% I10=zeros(Total+1,1);

%initialx=[458,134,606,0.00258,0.000097,0.000000677,0.000000686,0.0000975,0.0000154];
initialx=[2 5];
 
statenum=2;%state number

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


x =cellequoperation_ex1(@ex1,statenum,Total,h,initialx);%첫번째 항에 @함수이름 나머지 안고쳐도됨

xaxis=starttime:h:time;
figure(4);
for i=1:2
    subplot(1,2,i) 
    plot(xaxis,x(:,i));hold on;
end

%  subplot(3,3,2) 
%  plot(xaxis,x(:,2));
% 
%  subplot(3,3,3) 
%  plot(xaxis,x(:,3));
% 
%  subplot(3,3,4) 
%  plot(xaxis,x(:,4));
% 
%  subplot(3,3,5) 
%  plot(xaxis,x(:,5));
% 
%  subplot(3,3,6) 
%  plot(xaxis,x(:,6));
% 
%  subplot(3,3,7) 
%  plot(xaxis,x(:,7));
% 
%  subplot(3,3,8) 
%  plot(xaxis,x(:,8));
% 
%  subplot(3,3,9) 
%  plot(xaxis,x(9));
% 
% 
% 
% 
% 
% 
% 
% 
% 
