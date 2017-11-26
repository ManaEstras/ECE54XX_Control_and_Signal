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


k1k2 = place(bigA,bigb,dp1);
k1 = k1k2(1:4)
k2 = -k1k2(5)

l = place(A',c',dop)'


[num,den]=ss2tf(bigA-bigb*k1k2,bigb,bigc,d);
final_poles=roots(den)
final_zeros=roots(num)
[num3,den3] = ss2tf(A + b*k2,b,c,d);
finalx_zeros=roots(num3)
num3 = num3 / 0.4588;

figure(1)
dstep(num3,den,50)
title('Achieved b step response')
[y1,x1,t1] = dstep(num3,den);

figure(2)
[num2,den2]=ss2tf(bigA-bigbbar*k1k2,bigbbar,bigc,d);
[num4,den4] = ss2tf(A + bbar*k2,bbar,c,d);
final_poles=roots(den2)
final_zeros=roots(num2)
numx = num4 / 0.4588;
[y,x,t] = dstep(numx,den2);
dstep(numx,den2,50)
title('Achieved bar step response')
max(y)