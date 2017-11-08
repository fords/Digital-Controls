clear
clc
close all

filename='Lab2data.xlsx';
filename2='lab2dataVarin1234321kp0419.xlsx';


lab2data=xlsread(filename);
lab2data2=xlsread(filename2);


Data2=[lab2data(:,1),lab2data(:,2),lab2data(:,3)];
Datakp0419=[lab2data2(:,1),lab2data2(:,2),lab2data2(:,3),lab2data2(:,4),lab2data2(:,5)];

k=0.419;
k1=0.419;

t1=Data2(:,1);
t2=Datakp0419(:,1);


y1= Data2(:,2);
y2= Datakp0419(:,2);


u1= Data2(:,3);
u2= Datakp0419(:,3);

sp=Datakp0419(:,5);

Dat  =iddata(y1,u1,0.01);

sysTF = arx(Dat,[1 1 1]);
sysTF2O=arx(Dat,[2 2 1]);

tf1=tf(sysTF)
tf12O=tf(sysTF2O)


num=[k*0.6781];
num1=[0.8954*k1 0.2766];

den=[1 -.2814+k*0.6781];
den1=[1 (0.3951+0.8954*k1) (0.2766*k1-0.1814)];

sys=tf(num,den,0.1);
sys1=tf(num1,den1,0.1);

ys=lsim(tf1,u1);
ys2O=lsim(tf12O,u1);
ys1=lsim(sys,sp,t2);
ys12O=lsim(sys1,sp,t2);

close all;

figure;
plot(t1,y1,'-b*',t1,u1,'-.rs',t1,ys,'--g+');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Voltage Output','Voltage input','Lsim 1st order');
title('RC Circuit Sampled @ 100 Hz, Lsim 1st Order Approximation');

figure;
plot(t1,y1,'-b*',t1,u1,'-.rs',t1,ys2O,'--g+');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Voltage Output','Voltage input','Lsim 2nd order');
title('RC Circuit Sampled @ 100 Hz, Lsim 2nd Order Approximation');

figure;
plot(t2,sp,'-k',t2,y2,'-b*',t2,u2,'-.rs',t2,ys1,'--g+',t2,ys12O);
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Set Point','Voltage Output','Voltage input','Lsim 1st order','Lsim 2nd order');
title('RC Circuit Sampled @ 100 Hz K=0.419');

%first order linear
rms(ys-y1)
%second order
rms( ys2O - y1)
%simulation of output with 1,2,3, and 4 intput voltages p2p
rms(ys12O - y2)
rms(ys12O - y2)