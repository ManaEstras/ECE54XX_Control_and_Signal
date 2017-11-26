%exam4_a
clear all
clf

A = [0 0.3 -0.2 0.4;0.6 1.1 -0.2 -0.3; 0.4 0 0.7 -0.5;0 0.7 -0.3 0.6];
b = [0 1.8 -0.5 -0.3]';
c = [0 -0.6 0 -0.6];
ii = sqrt(-1);
dop = [-0.4 -0.3 -0.15 -0.1];
dcp = [0.7 + 0.4*ii,0.7 - 0.4*ii,0.4,0.2];

k = place(A,b,dcp)
l = place(A',c',dop)'

A1 = A-l*c-b*k;c1 = -k;

[Bz,Az] = ss2tf(A,b,c,0);
[Fz,Gz] = ss2tf(A1,b,c1,1);

A2 = A - l*c;
[Mz,Nz] = ss2tf(A2,l,k,0);

Yz = -conv(conv(Az,Gz),Nz)
Wz = conv(conv(Bz,Fz),Mz) + conv(Az,conv(Gz,Nz))
poles = roots(Wz)
zeros = roots(Yz)
figure(1)
pzmap(Yz,Wz)