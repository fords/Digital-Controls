
close all;
zeta = .50;
Pm = zeta*100;

% 1.5% steady state error
K = (1/.015 - 1)/.7905;  %gain



gain = 83.0698;
ww0 = .1*4.54;

a0 = db2mag(-17.8);

wwp = ww0/(gain*a0)

kp = gain*(wwp*(ww0+2/T)/(ww0*(wwp+2/T)))
z0 = ((2/T)-ww0)/((2/T)+ww0)
zp = ((2/T)-wwp)/((2/T)+wwp)

Dz = tf([kp -kp*z0],[1 -zp],.1)

figure(13)
bode(Dz*Gz)
hold on
margin(Dz*Gz)
grid on

figure(14)
sys2 = feedback(Dz*Gz,1);
step(sys2)
grid on
fm0 = bandwidth(sys2)

figure(15)
sys3 = Dz/(1+Dz*Gz);
step(sys3)
grid on

% Part G

figure(16)
step(CLTF);
hold on
step(CL);
hold on
step(sys0);
hold on
step(sys2);
grid on
legend('\zeta = 1','< 5% SS Error','\zeta = .8','Fastest Response','Location','Best')

figure(17)
step(M_R)
hold on
step(M_Ri)
hold on
step(sys1)
hold on
step(sys3)
axis([0 5 -10 10])
grid on
legend('\zeta = 1','< 5% SS Error','\zeta = .8','Fastest Response','Location','Best')