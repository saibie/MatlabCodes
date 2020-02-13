clear all
clc

z(1)=2.58e-6*0.01;
x1=2.58e-6*0.01;
z(2)=6.86e-8;
x2=6.86e-8;
z(3)=9.70e-9;
x3=9.70e-9;
z(4)=4.25e-6;
x4=4.25e-6;
z(5)=8.00e-6*0.07;
x5=8.00e-6*0.07;
z(6)=9.75e-6*0.69;
x6=9.75e-6*0.69;
z(7)=6.77e-12*0.44;
x7=6.77e-12*0.44;
z(8)=1.54e-6*0.49;
x8=1.54e-6*0.49;
z(9)=4.90e-8;
x9=4.90e-8;
z(10)=2.34e-2;
x10=2.34e-2;
z(11)=2.50e-2;
x11=2.50e-2;
z(12)=4.58e-2*1.5;
x12=4.58e-2*1.5;
z(13)=1.34e-2*0.78;
x13=1.34e-2*0.78;
z(14)=3.37e-1*1.5;
x14=3.37e-1*1.5;
z(15)=6.06e-2*0.29;
x15=6.06e-2*0.29;
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
% figure(1);%cell
% for j=1:6  
%     a(j)=subplot(2,3,j);
%     plot(a(j),xaxis,y(:,j+9),'r');
%      hline(j+9) = refline([0 z(j+9)]);
%      hline(j+9).LineStyle='--';
%      hline(j+9) = refline([0 u(j+9)]);
%      hline(j+9).LineStyle=':';
%      
% end
%      figure(1);title(a(1),'M1 macrophage','fontsize',14);
%      figure(1);  title(a(2),'M2 macrophage','fontsize',14);
%    figure(1);  title(a(3),'Th1 cell','fontsize',14);
%     figure(1); title(a(4),'Th2 cell','fontsize',14);
%     figure(1); title(a(5),'Th17 cell','fontsize',14);
%     figure(1); title(a(6),'Treg cell','fontsize',14);
%     figure(1); suptitle('Case 1 : Anti TNF-\alpha(Cells)')
%      %set(gca,'FontSize',20);
%     % suptitle('Case 4 \: No treatment ','fontsize',14)
%  %xlabel(a(i),'time(week)');
% for i=1:15
% for k=1:94000
%     D(k,i)=(y(k+6001,i)-y(k+6000,i))/(z(i)-u(i));
% end
% end
% 
% 
% for i=1:15
% for k=1:94000
%     
%     %정상>환자 up
%      if z(i)>u(i) && y(k+6001,i) > z(i) && y(k+6000,i) > z(i) &&...
%              (y(k+6001,i)-y(k+6000,i))>0;
%             H(k,i)=-D(k,i);
%      end
%     if z(i)>u(i) && z(i)>y(k+6001,i) && y(k+6001,i)>u(i)&&...
%                  z(i)> y(k+6000,i)  && y(k+6000,i) > u(i)&&...
%                  y(k+6001,i)-y(k+6000,i)>0;
%                 H(k,i)=D(k,i);
%     end
%        if z(i)>u(i) && y(k+6001,i) < u(i) && y(k+6000,i) < u(i) &&...
%            y(k+6001,i)-y(k+6000,i)>0;
%      H(k,i)=-D(k,i);
%      end
%    if z(i)>u(i) && y(k+6001,i) > z(i) && y(k+6001,i) > u(i)&&...
%      z(i) > y(k+6000,i) && y(k+6000,i) > u(i) &&...
%      y(k+6001,i)-y(k+6000,i)>0;
%       H(k,i)=-D(k,i);
%    end
%    if z(i)>u(i) && y(k+6001,i) < z(i) && y(k+6001,i) > u(i)&&...
%      z(i) > y(k+6000,i) && y(k+6000,i) < u(i) &&...
%      y(k+6001,i)-y(k+6000,i)>0;
%      H(k,i)=D(k,i);
%    end
%    
%    
%    %정상>환자 down
%    
%         if z(i)>u(i) && y(k+6001,i) > z(i) && y(k+6000,i) > z(i) &&...
%              (y(k+6001,i)-y(k+6000,i))<0;
%             H(k,i)=-D(k,i);
%      end
%     if z(i)>u(i) && z(i)>y(k+6001,i) && y(k+6001,i)>u(i)&&...
%                  z(i)> y(k+6000,i)  && y(k+6000,i) > u(i)&&...
%                  y(k+6001,i)-y(k+6000,i)<0;
%                 H(k,i)=D(k,i);
%     end
%        if z(i)>u(i) && y(k+6001,i) < u(i) && y(k+6000,i) < u(i) &&...
%            y(k+6001,i)-y(k+6000,i)<0;
%      H(k,i)=D(k,i);
%      end
%    if z(i)>u(i) && y(k+6001,i) < z(i) && y(k+6001,i) > u(i)&&...
%      z(i) < y(k+6000,i) && y(k+6000,i) > u(i) &&...
%      y(k+6001,i)-y(k+6000,i)<0;
%       H(k,i)=D(k,i);
%    end
%    if z(i)>u(i) && y(k+6001,i) < z(i) && y(k+6001,i) < u(i)&&...
%      z(i) > y(k+6000,i) && y(k+6000,i) > u(i) &&...
%      y(k+6001,i)-y(k+6000,i)<0;
%      H(k,i)=D(k,i);
%    end
%    
%    
%    %정상<환자 up
%    
%         if z(i)<u(i) && y(k+6001,i) > z(i) && y(k+6000,i) > z(i) &&...
%              (y(k+6001,i)-y(k+6000,i))>0;
%             H(k,i)=-D(k,i);
%      end
%     if z(i)<u(i) && z(i)>y(k+6001,i) && y(k+6001,i)>u(i)&&...
%                  z(i)> y(k+6000,i)  && y(k+6000,i) > u(i)&&...
%                  y(k+6001,i)-y(k+6000,i)>0;
%                 H(k,i)=-D(k,i);
%     end
%        if z(i)<u(i) && y(k+6001,i) < u(i) && y(k+6000,i) < u(i) &&...
%            y(k+6001,i)-y(k+6000,i)>0;
%      H(k,i)=D(k,i);
%      end
%    if z(i)<u(i) && y(k+6001,i) > z(i) && y(k+6001,i) > u(i)&&...
%      z(i) > y(k+6000,i) && y(k+6000,i) > u(i) &&...
%      y(k+6001,i)-y(k+6000,i)>0;
%       H(k,i)=-D(k,i);
%    end
%    if z(i)<u(i) && y(k+6001,i) < z(i) && y(k+6001,i) > u(i)&&...
%      z(i) > y(k+6000,i) && y(k+6000,i) < u(i) &&...
%      y(k+6001,i)-y(k+6000,i)>0;
%      H(k,i)=-D(k,i);
%    end
%    
%    
%    %정상<환자 down
%    
%         if z(i)<u(i) && y(k+6001,i) > z(i) && y(k+6000,i) > z(i) &&...
%              (y(k+6001,i)-y(k+6000,i))<0;
%             H(k,i)=D(k,i);
%      end
%     if z(i)<u(i) && z(i)>y(k+6001,i) && y(k+6001,i)>u(i)&&...
%                  z(i)> y(k+6000,i)  && y(k+6000,i) > u(i)&&...
%                  y(k+6001,i)-y(k+6000,i)<0;
%                 H(k,i)=-D(k,i);
%     end
%        if z(i)<u(i) && y(k+6001,i) < u(i) && y(k+6000,i) < u(i) &&...
%            y(k+6001,i)-y(k+6000,i)<0;
%      H(k,i)=D(k,i);
%      end
%    if z(i)<u(i) && y(k+6001,i) < z(i) && y(k+6001,i) > u(i)&&...
%      z(i) < y(k+6000,i) && y(k+6000,i) > u(i) &&...
%      y(k+6001,i)-y(k+6000,i)<0;
%       H(k,i)=-D(k,i);
%    end
%    if z(i)<u(i) && y(k+6001,i) < z(i) && y(k+6001,i) < u(i)&&...
%      z(i) > y(k+6000,i) && y(k+6000,i) > u(i) &&...
%      y(k+6001,i)-y(k+6000,i)<0;
%      H(k,i)=D(k,i);
%    end
% end
% end
% 
% for i=1:15
% S(1,i)=100*sum(H(:,i));
% end
% M=mean2(S);
% figure(8); 
% for i=1:15
%     b(i)=subplot(4,4,i);
%     %plot(xaxis,y(:,i),'r');hold on;
%     plot(1:94000,D(:,i));
% %axis([1,94000,-100,100]);
% %xlabel('time(week)','fontsize',14);
% %xticks([8 50 100])
% set(gca,'Xtick',[1:50000:94000]);
% set(gca,'XTickLabel',{'8','50','88'});
% end
% title(b(1),'IFN-\gamma','fontsize',14);
%        title(b(2),'IL-2','fontsize',14)
%       title(b(3),'IL-4','fontsize',14);
%      title(b(4),'IL-21','fontsize',14);
%      title(b(5),'IL-6','fontsize',14);
%      title(b(6),'TNF-\alpha','fontsize',14);
%      title(b(7),'TGF-\beta','fontsize',14);
%      title(b(8),'IL-10','fontsize',14);
%      title(b(9),'IL-12','fontsize',14);
%      title(b(10),'M1 macrophage','fontsize',14);
%       title(b(11),'M2 macrophage','fontsize',14);
%      title(b(12),'Th1 cell','fontsize',14);
%      title(b(13),'Th2 cell','fontsize',14);
%      title(b(14),'Th17 cell','fontsize',14);
%      title(b(15),'Treg cell','fontsize',14);
% suptitle('Impact factor of Drug');
% % plot(1:94000,D(:,1)*100000);
% % axis([1,94000,-1,0.8]);
% % xlabel('time(week)','fontsize',14);
% % title('Impact factor of Drug','fontsize',14);
% % %xticks([8 50 100])
% % set(gca,'Xtick',[1:8000:94000]);
% % set(gca,'XTickLabel',{'8','14','22','30','38','42','50','58','64','72','80','88'});
% 
% % figure(2);%pro
% % for k=1:9  
% %     a(k)=subplot(3,3,k);
% % end
% %     plot(a(1),xaxis,y(:,1),'r');
% %      hline(1) = refline(a(1),[0 z(1)]);
% %      hline(1).LineStyle='--';
% %     plot(a(2),xaxis,y(:,2),'r');
% %      hline(2) = refline(a(2),[0 z(2)]);
% %      hline(2).LineStyle='--';
% %       plot(a(3),xaxis,y(:,4),'r');
% %      hline(4) = refline(a(3),[0 z(4)]);
% %      hline(4).LineStyle='--';
% %       plot(a(4),xaxis,y(:,5),'r');
% %      hline(5) = refline(a(4),[0 z(5)]);
% %      hline(5).LineStyle='--';
% %       plot(a(5),xaxis,y(:,6),'r');
% %      hline(6) = refline(a(5),[0 z(6)]);
% %      hline(6).LineStyle='--';
% %       plot(a(6),xaxis,y(:,7),'r');
% %      hline(7) = refline(a(6),[0 z(7)]);
% %      hline(7).LineStyle='--';
% %       plot(a(8),xaxis,y(:,9),'r');
% %      hline(9) = refline(a(8),[0 z(9)]);
% %      hline(9).LineStyle='--';
% 
% 
% figure(2);%pro
% subplot(3,3,1);
%     plot(xaxis,y(:,1),'r');
%     title('IFN-\gamma','fontsize',14);
%      hline(1) = refline([0 z(1)]);
%      hline(1).LineStyle='--';
%      hline(21) = refline([0 u(1)]);
%      hline(21).LineStyle='-.';
%      
%      subplot(3,3,2);
%     plot(xaxis,y(:,2),'r');
%      title('IL-2','fontsize',14);
%      hline(2) = refline([0 z(2)]);
%      hline(2).LineStyle='--';
%      hline(22) = refline([0 u(2)]);
%      hline(22).LineStyle='-.';
%      
%      subplot(3,3,3);
%       plot(xaxis,y(:,4),'r');
%       title('IL-21','fontsize',14);
%      hline(4) = refline([0 z(4)]);
%      hline(4).LineStyle='--';
%      hline(24) = refline([0 u(4)]);
%      hline(24).LineStyle='-.';
%      
%      subplot(3,3,4);
%       plot(xaxis,y(:,5),'r');
%       title('IL-6','fontsize',14);
%      hline(5) = refline([0 z(5)]);
%      hline(5).LineStyle='--';
%      hline(25) = refline([0 u(5)]);
%      hline(25).LineStyle='-.';
%      
%      subplot(3,3,5);
%       plot(xaxis,y(:,6),'r');
%       title('TNF-\alpha','fontsize',14);
%      hline(6) = refline([0 z(6)]);
%      hline(6).LineStyle='--';
%      hline(26) = refline([0 u(6)]);
%      hline(26).LineStyle='-.';
%      
%      subplot(3,3,6);
%       plot(xaxis,y(:,7),'r');
%       title('TGF-\beta','fontsize',14);
%      hline(7) = refline([0 z(7)]);
%      hline(7).LineStyle='--';
%      hline(27) = refline([0 u(7)]);
%      hline(27).LineStyle='-.';
%      
%      subplot(3,3,8);
%       plot(xaxis,y(:,9),'r');
%        title('IL-12','fontsize',14);
%      hline(9) = refline([0 z(9)]);
%      hline(9).LineStyle='--';
%      hline(29) = refline([0 u(9)]);
%      hline(29).LineStyle='-.';
% 
%    figure(2);  suptitle('Case 1 : Anti TNF-\alpha(Pro-inflammtory Cytokines)')
% 
%  figure(3);%anti
% 
% subplot(1,2,1);
% plot(xaxis,y(:,3),'r');
% title('IL-4','fontsize',14);
%      hline(1) = refline([0 z(3)]);
%      hline(1).LineStyle='--';
%      hline(21) = refline([0 u(3)]);
%      hline(21).LineStyle='-.';
%      
%      subplot(1,2,2);
%     plot(xaxis,y(:,8),'r');
%     title('IL-10','fontsize',14);
%      hline(2) = refline([0 z(8)]);
%      hline(2).LineStyle='--';
%      hline(22) = refline([0 u(8)]);
%      hline(22).LineStyle='-.';
%      
% 
%    figure(3);  suptitle('Case 1 : Anti TNF-\alpha(Anti-inflammtory Cytokines)')
   
   
  figure(4);hold on;
%i=1:16;
%a(i)=subplot(4,4,i);
 for i=1:15
     a(i)=subplot(4,4,i);
    l=plot(xaxis,y(:,i),'r');hold on;
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
%   suptitle('Case 1 : Anti TNF-\alpha(Total) ')
%legend([l,u(1),z(1)],{'Variables', 'Healthy individal standard','Patient standard'});
     

% # Create the legend
% fig.legend([l1, l2, l3, l4],     # The line objects
%            labels=line_labels,   # The labels for each line
%            loc="center right",   # Position of legend
%            borderaxespad=0.1,    # Small spacing around legend box
%            title="Legend Title"  # Title for the legend
%            )%xlabel(a(i),'time(week)','fontsize',14);
     %ylabel(a(i),'time(week)','fontsize',14);
