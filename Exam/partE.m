zeta = .8;
Pm = zeta*100;

figure(9)
bode(Gz)
hold on
margin(Gz)


gain = 25;
ww0 = .244;
mag_a = db2mag(-11.2)
wwp  = ww0/(gain*mag_a)

kp = gain*(wwp*(ww0+2/T)/(ww0*(wwp+2/T)))
z0 = ((2/T)-ww0)/((2/T)+ww0)
zp = ((2/T)-wwp)/((2/T)+wwp)

Dz = tf([kp -kp*z0],[1 -zp],.1)

figure(10)
bode(Dz*Gz)
hold on
margin(Dz*Gz)

figure(11)
sys0 = feedback(Dz*Gz,1);
step(sys0)
freq = bandwidth(sys0)

figure(12)
sys1 = Dz/(1+Dz*Gz);
step(sys1)

