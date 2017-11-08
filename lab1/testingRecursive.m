
P=[];F=[];L=[];theta=[a;b];

u=[1;.75;.5;.4];
y=[0;0.3;0.225;0.150];
for N = 1:2
        F =[u(N,1) y(N,1)
            u(N+1,1) Y(N+1,1)];
        f =F(N,:);
        f2=F(N+1,:);
        PN= finverse( F.'*F);
        LN= P
        theta = finverse(F*F.')*(F.')*[y(N,1) ; y(N+1,1)];
end