%exam5_a
%Jieneng Yang

clear all
clc

A = [1.3 -0.2 0.3 0
    -0.2 0.9 0.5 -0.3
    0 0.5 0.4 0.2
    0 0 -0.2 0.7];
b = [1.8;0;0;-0.2];
bbar = [1.71;-0.12;0.05;-0.23];
c = [0.1 -0.3 -0.5 0];

ii = sqrt(-1);
d = 0;
dp1 = [0.6+0.4*ii 0.6 - 0.4*ii 0.4 0.35 0.3];
dop = [0.2 0.15+0.1*ii 0.15-0.1*ii 0.1]
bigA = [1.3 -0.2 0.3 0 0
        -0.2 0.9 0.5 -0.3 0
        0 0.5 0.4 0.2 0
        0 0 -0.2 0.7 0
        -0.1 0.3 0.5 0 1];
bigb = [1.8;0;0;-0.2;0];
bigc = [c 0];
bigbbar = [1.71;-0.12;0.05;-0.23;0];


[num,den]=ss2tf(A,b,c,d);
plant_poles=roots(den)
plant_zeros=roots(num)
figure(1)


k1k2 = place(bigA,bigb,dp1);
k1 = k1k2(1:4)
k2 = -k1k2(5)
l = place(A',c',dop)'


F = [A -b*k1 b*k2;l*c A-l*c-b*k1 b*k2;-c zeros(1,4) 1];
g = [zeros(1,8) 1]';
h = [c zeros(1,5)];
p = 0;
figure(1)
subplot(211)
pzmap(F,g,h,p)
title('Achieved singularities')
subplot(212)
[y1,x,t] = dstep(F,g,h,p,1);
plot(y1)
title('Achieved step response')


Fbar = [A -bbar*k1 bbar*k2;l*c A-l*c-bbar*k1 bbar*k2;-c zeros(1,4) 1];
g = [zeros(1,8) 1]';
h = [c zeros(1,5)];
p = 0;
figure(2)
subplot(211)
pzmap(Fbar,g,h,p)
title('Achieved singularities')
subplot(212)
[y,x,t] = dstep(Fbar,g,h,p,1);
plot(y)

title('Achieved step response')
[maxy,tt] = max(y)


