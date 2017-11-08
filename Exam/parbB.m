num = [20 400];
den = [1 106 605 500];
T = .1;
Gp = tf(num,den)
Gz = c2d(Gp,.1,'zoh')


k = .976;
CL = feedback(k*Gz,1);
figure(3)
step(CL)


CLTF = (k*Gz)/(1+k*Gz);
figure(4)
step(CLTF)

M_R = k/(1+k*Gz);
figure(5)
step(M_R)


ki = 26;
CL = feedback(ki*Gz,1);
figure(6)
step(CL)
grid on;

M_Ri = ki/(1+(ki*Gz));
figure(7)
step(M_Ri)
grid on;
