clear all
clc

A = importdata('BSfludat.csv');
A = A.data;
tdata = A(:,1);
qdata = A(:,2);

tforward = 3:0.01:14;
tmeasure = 1:100:1101;

y0 = [738,25];
k0 = [0.4;0.003];

kest = fminsearch(@(p)devi(tforward,p,qdata,y0),k0);

[test,yest] = ode45(@SIS_model,tforward,y0,[],kest);

yint = yest(tmeasure,2);
         
figure
plot(tdata,qdata,'ro')
hold on
plot(test,yest(:,2),'b-')
axis([3 14 0 350])