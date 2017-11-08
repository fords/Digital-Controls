clear
clc
close all

filename='lab4_0to2V_86RPM.xlsx';
filename1='lab4_0to4V_174RPM.xlsx';

% Reading Excel file to gather data to be interpreted
lab3data=xlsread(filename);
lab3q10=xlsread(filename1);

Data3=[lab3data(:,1),lab3data(:,2),lab3data(:,3)];
Data3q10=[lab3q10(:,1),lab3q10(:,2),lab3q10(:,3)];

t2=Data3q10(:,1);
Vcmd2=Data3q10(:,2);
Vcap2=Data3q10(:,3);

t1=Data3(:,1);
Vcmd1= Data3(:,2);
Vcap1=Data3(:,3);

% Arx Data for question 10
Dat1=iddata(Vcap2,Vcmd2,0.1);
sysTF10=arx(Dat1,[1 1 1]);
tf2=tf(sysTF10)
ys10=lsim(tf2,Vcmd2);

% Arx Data for sys ID for G(z) to be used in CLTF
Dat=iddata(Vcap1,Vcmd1,0.1);
sysTF = arx(Dat,[1 1 1]);
tf1=tf(sysTF)
ys=lsim(tf1,Vcmd1);

close all;
open_system('lab4')
sim('lab4');

figure;
plot(t1,Vcap1,'--k',t1,Vcmd1,'-b*',t1,Vcap1,'-.rs',t1,ys,'--g+');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Vcmd','Vsp','Vcap','Lsim1 1st Order');
title('Sampled data with Lsim 1st Order Approximation');
axis([0 13 -1 6])

figure;
plot(tout,simout,t1,(1/0.0172)*Vcmd1)
legend('sim', 'real');
title('RPMin vs RPMout with 10% error');
xlabel('Time - Seconds');
ylabel('Amplitude - RPM');

figure;
plot(tout,simout1,t1,(1/0.0172)*Vcmd1)
legend('sim', 'real');
title('RPMin vs RPMout with 10% error');
xlabel('Time - Seconds');
ylabel('Amplitude - RPM');
%% 
ktach=1/0.0172;
tf=12;
sim('lab4')
figure(100),plot(tim100200(1:241),output100200(1:241)*ktach,tout,simout1*ktach,tim100200(1:241),VspVolts(1:241)*ktach)
figure(101),plot(tim22(1:241),RPM22(1:241),tout,simout,tim22(1:241),Vsp22(1:241))

title('System Response: 0-100RPM')