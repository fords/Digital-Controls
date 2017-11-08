filename='DigitalControlsLab1Data.xlsx';
filename2='DigitalControlsLab1Data2fivehurtz.xlsx';
filename3='DigitalControlsLab1Data2twentyhurtz.xlsx';

Data=xlsread(filename);
Data2FiveHurtz=xlsread(filename2);
Data2TwentyHurtz=xlsread(filename3);

Data1=[Data(:,1),Data(:,2),Data(:,4)];
Data25h=[Data2FiveHurtz(:,1),Data2FiveHurtz(:,2),Data2FiveHurtz(:,4)];
Data220h=[Data2TwentyHurtz(:,1),Data2TwentyHurtz(:,2),Data2TwentyHurtz(:,4)];

D1=Data1(:,2);
D25h=Data25h(:,2);
D220h=Data220h(:,2);
 
[row,col,v]=find(abs(diff(Data1,1,1))>.8);
[row1,col1,v1]=find(abs(diff(Data25h,1,1))>.8);
[row2,col2,v2]=find(abs(diff(Data220h,1,1))>.8);
 
row=row+1;
row1=row1+1;
row2=row2+1;
 
ytup=Data1(row(2):row(3)-1,1);
ytup1=Data25h(row1(2):row1(3)-1,1);
ytup2=Data220h(row2(2):row2(3)-1,1);
 
Vactup=Data1(row(2):row(3)-1,2);
Vactup1=Data25h(row1(2):row1(3)-1,2);
Vactup2=Data220h(row2(2):row2(3)-1,2);

close all;
figure;
plot(Data25h(:,1),Data25h(:,2),Data25h(:,1),Data25h(:,3),ytup1,Vactup1,'k');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Voltage Output','Voltage input','Single Falling Wave');
title('Full RC Circuit Sampled at 0.1 Hz');
figure;
plot(Data1(:,1),Data1(:,2),Data1(:,1),Data1(:,3),ytup,Vactup,'k');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Voltage Output','Voltage input','Single Falling Wave');
title('Partial RC Circuit Sampled @ 0.2 Hz');
figure;
plot(Data220h(:,1),Data220h(:,2),Data220h(:,1),Data220h(:,3),ytup2,Vactup2,'k');
xlabel('Time - Seconds');
ylabel('Voltage - Volts');
grid minor;
legend('Voltage Output','Voltage input','Single Falling Wave');
title('Full RC Circuit Sampled @ 0.1 Hz');

Dat=iddata(Data1(:,2),Data1(:,3),0.05);
Dat1=iddata(Data25h(:,2),Data25h(:,3),0.2);
Dat2=iddata(Data220h(:,2),Data220h(:,3),0.05);

sysTF= arx(Dat,[1 1 1]);
sysTF1= arx(Dat1,[ 1 1 1]);
sysTF2= arx(Dat2,[1 1 1]);

%sysTF=tfest(Dat,1,0,nan);
%sysTF1=tfest(Dat1,1,0,nan);
%sysTF2=tfest(Dat2,1,0,nan);

step(sysTF);
figure;
step(sysTF1);
figure;
step(sysTF2);


