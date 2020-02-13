x = [-1:.001:5];
y = (x - 1).*(x - 3)./2 + 1;

plot(x,y,'b','LineWidth',2);hold on;
plot([-1 5],[0 0],'k',[0 0],[-1 5],'k');axis equal;axis([-1 5 -1 5]);

pause

hold off
plot(x,y,'b','LineWidth',2);hold on;
plot([-1 5],[0 0],'k',[0 0],[-1 5],'k');axis equal;axis([-1 5 -1 5]);
x1(1) = 1; x1(2) = 4;
y1 = (x1 - 1).*(x1 - 3)./2 + 1;
plot(x1,y1,'r')
x2 = linspace(x1(1),x1(2),15);
y2 = (x2 - 1).*(x2 - 3)./2 + 1;
z2 = (y1(1)-y1(2))./(x1(1)-x1(2)).*(x2 - x1(1)) + y1(1);
for i=1:15
    plot([x2(i) x2(i)],[y2(i) z2(i)],'g');
end

pause

hold off
plot(x,y,'b','LineWidth',2);hold on;
plot([-1 5],[0 0],'k',[0 0],[-1 5],'k');axis equal;axis([-1 5 -1 5]);
x1(1) = -.5; x1(2) = 2.5;
y1 = (x1 - 1).*(x1 - 3)./2 + 1;
plot(x1,y1,'r')
x2 = linspace(x1(1),x1(2),15);
y2 = (x2 - 1).*(x2 - 3)./2 + 1;
z2 = (y1(1)-y1(2))./(x1(1)-x1(2)).*(x2 - x1(1)) + y1(1);
for i=1:15
    plot([x2(i) x2(i)],[y2(i) z2(i)],'g');
end

pause

hold off
plot(x,y,'b','LineWidth',2);hold on;
plot([-1 5],[0 0],'k',[0 0],[-1 5],'k');axis equal;axis([-1 5 -1 5]);
x1(1) = 0; x1(2) = 4.5;
y1 = (x1 - 1).*(x1 - 3)./2 + 1;
plot(x1,y1,'r')
x2 = linspace(x1(1),x1(2),15);
y2 = (x2 - 1).*(x2 - 3)./2 + 1;
z2 = (y1(1)-y1(2))./(x1(1)-x1(2)).*(x2 - x1(1)) + y1(1);
for i=1:15
    plot([x2(i) x2(i)],[y2(i) z2(i)],'g');
end

