clear
clc
close all

filename='DigitalControlsLab1Data.xlsx';
filename2='DigitalControlsLab1Data2fivehurtz.xlsx';
filename3='DigitalControlsLab1Data2twentyhurtz.xlsx';
filename4='5hzRC.xlsx';
filename5='10hzRC.xlsx';

Data=xlsread(filename);
Data2in=xlsread(filename4);
Data3in=xlsread(filename5);
Data2FiveHurtz=xlsread(filename2);
Data2TwentyHurtz=xlsread(filename3);

Data1=[Data(:,1),Data(:,2),Data(:,4)];
Data2=[Data2in(:,1),Data2in(:,2),Data2in(:,4)];
Data3=[Data3in(:,1),Data3in(:,2),Data3in(:,4)];
Data25h=[Data2FiveHurtz(:,1),Data2FiveHurtz(:,2),Data2FiveHurtz(:,4)];
Data220h=[Data2TwentyHurtz(:,1),Data2TwentyHurtz(:,2),Data2TwentyHurtz(:,4)];

t1=Data1(:,1);
t2=Data25h(:,1);
t3=Data220h(:,1);
t4=Data2(:,1);
t5=Data3(:,1);

y1=Data1(:,2);
y2=Data25h(:,2);
y3=Data220h(:,2);  
y4=Data2(:,2);
y5=Data3(:,2);

u1=Data1(:,3);
u2=Data25h(:,3);
u3=Data220h(:,3);  
u4=Data2(:,3);
u5=Data3(:,3);

psi1 =[-y1(1:size(y1,1)-1) , u1(1:size(u1,1)-1)];
psi2 =[-y2(2:size(y2,1)-1) , -y2(1:size(y2,1)-2) , u2(2:size(u2,1)-1) , u2(1:size(u2,1)-2)];
psi3 =[-y3(2:size(y3,1)-1) , -y3(1:size(y3,1)-2) , u3(2:size(u3,1)-1) , u3(1:size(u3,1)-2)];
psi4 =[-y4(1:size(y4,1)-1) , u4(1:size(u4,1)-1)];
psi5 =[-y5(1:size(y5,1)-1) , u5(1:size(u5,1)-1)];

yout1=y1(2:size(y1,1));  
yout2=y2(3:size(y2,1));
yout3=y3(3:size(y3,1));
yout4=y4(2:size(y4,1));
yout5=y5(2:size(y5,1));

theta1=(psi1'*psi1)\psi1'*yout1;
theta2=(psi2'*psi2)\psi2'*yout2;
theta3=(psi3'*psi3)\psi3'*yout3;
theta4=(psi4'*psi4)\psi4'*yout4;
theta5=(psi5'*psi5)\psi5'*yout5;

disp('Theta for First Order RC circuit');
disp(theta4);
disp(theta5);
disp(theta1);
disp('Theta for Second Order RC-RC circuit');
disp(theta2);
disp(theta3);

Dat  =iddata(Data1(:,2),Data1(:,3),0.05);
Dat1 =iddata(Data25h(:,2),Data25h(:,3),0.2);
Dat2 =iddata(Data220h(:,2),Data220h(:,3),0.05);
Dat3=iddata(Data2(:,2),Data2(:,3),0.2);
Dat4=iddata(Data3(:,2),Data3(:,3),0.1);

sysTF =arx(Dat,[1 1 1]);
sysTF1=arx(Dat1,[2 2 1]);
sysTF2=arx(Dat2,[2 2 1]);
sysTF3=arx(Dat3,[1 1 1]);
sysTF4=arx(Dat4,[1 1 1]);
sysTF5=arx(Dat1,[1 1 1]);
sysTF6=arx(Dat2,[1 1 1]);

disp('The Z-domain Transfer functions for First Order Approximate RC');
tf4=tf(sysTF3)
tf5=tf(sysTF4)
tf1=tf(sysTF)
disp('The Z-domain Transfer functions for First Order Approximate RC-RC');
tf6=tf(sysTF5)
tf7=tf(sysTF6)
disp('The Z-domain Transfer functions for Second Order Approximate RC-RC');
tf2=tf(sysTF1)
tf3=tf(sysTF2)

disp('The S-domain Transfer functions for First Order Approximate RC');
tf4s=d2c(tf4)
tf5s=d2c(tf5)
tf1s=d2c(tf1)
disp('The S-domain Transfer functions for First Order Approximate Rc-RC');
tf6s=d2c(tf6)
tf7s=d2c(tf7)
disp('The S-domain Transfer functions for Second Order Approximate RC-RC');
tf2s=d2c(tf2)
tf3s=d2c(tf3)

r1=39e3;c1=10e-6;r2=39e3;c2=10e-6;
num=(1);den=[r1*r2*c1*c2 (r1*c1+r2*c2+r1*c2) 1];
tau=1./roots([r1*r2*c1*c2 (r1*c1+r2*c2+r1*c2) 1]);

ys=lsim(sysTF,Data1(:,3),Data1(:,1));
ys1=lsim(sysTF1,Data25h(:,3),Data25h(:,1));
ys2=lsim(sysTF2,Data220h(:,3),Data220h(:,1));
ys3=lsim(sysTF3,Data2(:,3),Data2(:,1));
ys4=lsim(sysTF4,Data3(:,3),Data3(:,1));
ys5=lsim(sysTF5,Data25h(:,3),Data25h(:,1));
ys6=lsim(sysTF6,Data220h(:,3),Data220h(:,1));

%
ycont=lsim(tf1s,Data1(:,3),Data1(:,1));
ycont1=lsim(tf2s,Data25h(:,3),Data25h(:,1));
ycont2=lsim(tf3s,Data220h(:,3),Data220h(:,1));
ycont3=lsim(tf4s,Data2(:,3),Data2(:,1));
ycont4=lsim(tf5s,Data3(:,3),Data3(:,1));

%
disp(['1st order RC arx @ 5 Hz RMS = ',num2str(rms(ys3-Data2(:,3)))])
disp(['1st order RC arx @ 10 Hz RMS = ',num2str(rms(ys4-Data3(:,3)))])
disp(['1st order RC arx @ 20 Hz RMS = ',num2str(rms(ys-Data1(:,3)))])
disp(['2nd order RC arx @ 5 Hz RMS = ',num2str(rms(ys5-Data25h(:,3)))])
disp(['2nd order RC arx @ 20 Hz RMS = ',num2str(rms(ys6-Data220h(:,3)))])
disp(['2nd order RC Lsim2nd arx @ 5 Hz RMS = ',num2str(rms(ys1-Data25h(:,3)))])
disp(['2nd order RC Lsim2nd arx @ 20 Hz RMS = ',num2str(rms(ys2-Data220h(:,3)))])

% 
%

close all;

figure;
plot(t4,y4,'-b*',t4,u4,'-.rs',t4,ys3,'--g+',t4,ycont3,'-ks');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Volt Out','Volt in','Lsim 1st','Continuous');
title('RC Circuit Sampled @ 5 Hz');

figure;
plot(t5,y5,'-b*',t5,u5,'-.rs',t5,ys4,'--g+',t5,ycont4,'-ks');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Volt Out','Volt in','Lsim 1st','Continuous');
title('RC Circuit Sampled @ 10 Hz');

figure;
plot(t1,y1,'-b*',t1,u1,'-.rs',t1,ys,'--g+',t1,ycont,'-ks');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Volt Out','Volt in','Lsim 1st','Continuous');
title('RC Circuit Sampled @ 20 Hz');

figure;
plot(t2,y2,'-b*',t2,u2,'-.rs',t2,ys1,'--g+',t2,ys5,'-ks',t2,ycont1,'-c');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Volt Out','Volt in','Lsim 2nd','Lsim 1st','Continuous');
title('RC-RC Circuit Sampled at 5 Hz');

figure;
plot(t3,y3,'-b*',t3,u3,'-.rs',t3,ys2,'--g+',t3,ys6,'ks',t3,ycont2,'-c');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Volt Out','Volt in','Lsim 2nd','Lsim 1st','Continuous');
title('RC-RC Circuit Sampled @ 20 Hz');

