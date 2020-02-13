clear all
clc

z(1)=2.58e-6*0.08;
x1=2.58e-6*0.08;
z(2)=6.86e-8;
x2=6.86e-8;
z(3)=9.70e-9;
x3=9.70e-9;
z(4)=4.25e-6;
x4=4.25e-6;
z(5)=8.00e-6*0.26;
x5=8.00e-6*0.26;
z(6)=9.75e-6*0.69;
x6=9.75e-6*0.69;
z(7)=6.77e-12*0.96;
x7=6.77e-12*0.96;
z(8)=1.54e-6*0.85;
x8=1.54e-6*0.85;
z(9)=4.90e-8;
x9=4.90e-8;
z(10)=2.34e-2;
x10=2.34e-2;
z(11)=2.50e-2;
x11=2.50e-2;
z(12)=4.58e-2*0.71;
x12=4.58e-2*0.71;
z(13)=1.34e-2*1.5;
x13=1.34e-2*1.5;
z(14)=3.37e-1*0.73;
x14=3.37e-1*0.73;
z(15)=6.06e-2*1.01;
x15=6.06e-2*1.01;
%z(16)=107;
x16=107;

% z(1)=2.58e-6;
% x1=2.58e-6;
% z(2)=6.86e-8;
% x2=6.86e-8;
% z(3)=9.70e-9;
% x3=9.70e-9;
% z(4)=4.25e-6;
% x4=4.25e-6;
% z(5)=8.00e-6;
% x5=8.00e-6;
% z(6)=9.75e-6;
% x6=9.75e-6;
% z(7)=6.77e-12;
% x7=6.77e-12;
% z(8)=1.54e-6;
% x8=1.54e-6;
% z(9)=4.90e-8;
% x9=4.90e-8;
% z(10)=2.34e-2;
% x10=2.34e-2;
% z(11)=2.50e-2;
% x11=2.50e-2;
% z(12)=4.58e-2;
% x12=4.58e-2;
% z(13)=1.34e-2;
% x13=1.34e-2;
% z(14)=3.37e-1;
% x14=3.37e-1;
% z(15)=6.06e-2;
% x15=6.06e-2;
% %z(16)=107;
% x16=107;




%initialx=[458,134,606,0.00258,0.000097,0.000000677,0.000000686,0.0000975,0.0000154];
initialx=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16];
%initialx=[2 5];
 
statenum=16;%state number

%time
starttime=0;%���۽ð�
time=100; %�������ð�
h=0.001;

Total=(time-starttime)/h;%�ѽð�����
%������� �Ȱǵ鿩����

%controltimeint=8;
%imp=controltimeint*ones(1,fix(time/controltimeint));%control �ð� ����
%implocation=[6];%control state
%drate=[0.3];%control�� ������� ����

u=[1.21E-06	2.22E-08	1.48E-08	4.42E-06	3.50E-06...
    4.07E-05	7.63E-13	2.06E-06	3.82E-07	0.028053564...
    0.011954641	0.291488418	0.025600383	0.351571555	0.007310019];




y =cellequoperation_ex1(@orgi42_pa,statenum,Total,h,initialx);%ù��° �׿� @�Լ��̸� ������ �Ȱ��ĵ���
xaxis=starttime:h:time;
figure(1);%cell
for j=1:6  
    a(j)=subplot(2,3,j);
    plot(a(j),xaxis,y(:,j+9),'r');
     hline(j+9) = refline([0 z(j+9)]);
     hline(j+9).LineStyle='--';
     hline(j+9) = refline([0 u(j+9)]);
     hline(j+9).LineStyle=':';
     
end
     figure(1);title(a(1),'M1 macrophage','fontsize',14);
     figure(1);  title(a(2),'M2 macrophage','fontsize',14);
   figure(1);  title(a(3),'Th1 cell','fontsize',14);
    figure(1); title(a(4),'Th2 cell','fontsize',14);
    figure(1); title(a(5),'Th17 cell','fontsize',14);
    figure(1); title(a(6),'Treg cell','fontsize',14);
    figure(1); 
    %suptitle('Case 2 : Anti TNF-\alpha(Cells)')
     %set(gca,'FontSize',20);
    % suptitle('Case 4 \: No treatment ','fontsize',14)
 %xlabel(a(i),'time(week)');
for i=1:15
for k=1:99200
     D(k,i)=(y(k+801,i)-y(k+800,i))*100/(z(i)-u(i));
end
end
S=sum(D);
M=mean2(S);
figure(8);
plot(1:99200,D(:,1)*100000);
% figure(2);%pro
% for k=1:9  
%     a(k)=subplot(3,3,k);
% end
%     plot(a(1),xaxis,y(:,1),'r');
%      hline(1) = refline(a(1),[0 z(1)]);
%      hline(1).LineStyle='--';
%     plot(a(2),xaxis,y(:,2),'r');
%      hline(2) = refline(a(2),[0 z(2)]);
%      hline(2).LineStyle='--';
%       plot(a(3),xaxis,y(:,4),'r');
%      hline(4) = refline(a(3),[0 z(4)]);
%      hline(4).LineStyle='--';
%       plot(a(4),xaxis,y(:,5),'r');
%      hline(5) = refline(a(4),[0 z(5)]);
%      hline(5).LineStyle='--';
%       plot(a(5),xaxis,y(:,6),'r');
%      hline(6) = refline(a(5),[0 z(6)]);
%      hline(6).LineStyle='--';
%       plot(a(6),xaxis,y(:,7),'r');
%      hline(7) = refline(a(6),[0 z(7)]);
%      hline(7).LineStyle='--';
%       plot(a(8),xaxis,y(:,9),'r');
%      hline(9) = refline(a(8),[0 z(9)]);
%      hline(9).LineStyle='--';


figure(2);%pro
subplot(3,3,1);
    plot(xaxis,y(:,1),'r');
    title('IFN-\gamma','fontsize',14);
     hline(1) = refline([0 z(1)]);
     hline(1).LineStyle='--';
     hline(21) = refline([0 u(1)]);
     hline(21).LineStyle='-.';
     
     subplot(3,3,2);
    plot(xaxis,y(:,2),'r');
     title('IL-2','fontsize',14);
     hline(2) = refline([0 z(2)]);
     hline(2).LineStyle='--';
     hline(22) = refline([0 u(2)]);
     hline(22).LineStyle='-.';
     
     subplot(3,3,3);
      plot(xaxis,y(:,4),'r');
      title('IL-21','fontsize',14);
     hline(4) = refline([0 z(4)]);
     hline(4).LineStyle='--';
     hline(24) = refline([0 u(4)]);
     hline(24).LineStyle='-.';
     
     subplot(3,3,4);
      plot(xaxis,y(:,5),'r');
      title('IL-6','fontsize',14);
     hline(5) = refline([0 z(5)]);
     hline(5).LineStyle='--';
     hline(25) = refline([0 u(5)]);
     hline(25).LineStyle='-.';
     
     subplot(3,3,5);
      plot(xaxis,y(:,6),'r');
      title('TNF-\alpha','fontsize',14);
     hline(6) = refline([0 z(6)]);
     hline(6).LineStyle='--';
     hline(26) = refline([0 u(6)]);
     hline(26).LineStyle='-.';
     
     subplot(3,3,6);
      plot(xaxis,y(:,7),'r');
      title('TGF-\beta','fontsize',14);
     hline(7) = refline([0 z(7)]);
     hline(7).LineStyle='--';
     hline(27) = refline([0 u(7)]);
     hline(27).LineStyle='-.';
     
     subplot(3,3,8);
      plot(xaxis,y(:,9),'r');
       title('IL-12','fontsize',14);
     hline(9) = refline([0 z(9)]);
     hline(9).LineStyle='--';
     hline(29) = refline([0 u(9)]);
     hline(29).LineStyle='-.';

   figure(2);  %suptitle('Case 2 : Anti TNF-\alpha(Pro-inflammtory Cytokines)')

 figure(3);%anti

subplot(1,2,1);
plot(xaxis,y(:,3),'r');
title('IL-4','fontsize',14);
     hline(1) = refline([0 z(3)]);
     hline(1).LineStyle='--';
     hline(21) = refline([0 u(3)]);
     hline(21).LineStyle='-.';
     
     subplot(1,2,2);
    plot(xaxis,y(:,8),'r');
    title('IL-10','fontsize',14);
     hline(2) = refline([0 z(8)]);
     hline(2).LineStyle='--';
     hline(22) = refline([0 u(8)]);
     hline(22).LineStyle='-.';
     

   figure(3); % suptitle('Case 2 : Anti TNF-\alpha(Anti-inflammtory Cytokines)')
   
   
  figure(4);
%i=1:16;
%a(i)=subplot(4,4,i);
 for i=1:15
     a(i)=subplot(4,4,i);
    plot(xaxis,y(:,i),'r');hold on;
     %xlabel(a(i),'time(week)','fontsize',14);
     %ylabel(a(i),'time(week)','fontsize',14);
     hline(i) = refline(a(i),[0 z(i)]);
     hline(i).LineStyle='--';
     hline(i) = refline([0 u(i)]);
     hline(i).LineStyle='-.';

    
 end
 
      title(a(1),'IFN-\gamma','fontsize',14);
       title(a(2),'IL-2','fontsize',14)
      title(a(3),'IL-4','fontsize',14);
     title(a(4),'IL-21','fontsize',14);
     title(a(5),'IL-6','fontsize',14);
     title(a(6),'TNF-\alpha','fontsize',14);
     title(a(7),'TGF-\beta','fontsize',14);
     title(a(8),'IL-10','fontsize',14);
     title(a(9),'IL-12','fontsize',14);
     title(a(10),'M1 macrophage','fontsize',14);
      title(a(11),'M2 macrophage','fontsize',14);
     title(a(12),'Th1 cell','fontsize',14);
     title(a(13),'Th2 cell','fontsize',14);
     title(a(14),'Th17 cell','fontsize',14);
     title(a(15),'Treg cell','fontsize',14);
 subplot(4,4,16);
 plot(xaxis,y(:,16),'r');
 title('Anti TNF-\alpha','fontsize',14);
%  suptitle('Case 2 : Anti TNF-\alpha(Total) ')
     %xlabel(a(i),'time(week)','fontsize',14);
     %ylabel(a(i),'time(week)','fontsize',14);