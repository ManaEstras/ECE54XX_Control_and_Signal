%dfps
%dynamic feedback pole shifting
% Jieneng Yang exam3_a

clear, clf, hold off

%use leading and trailing zeros as needed
%to make lengths of a and b match
ii = sqrt(-1);
a=poly([1.17 0.73,0.53 + 0.26 * ii,0.53 - 0.26 * ii]);
b=[0 0 3.4 * poly([-0.96 -0.51])];


figure(1)
d=poly([0.47 + 0.32 * ii 0.47 - 0.32 * ii -0.18 -0.23]);%desire
l=poly([-0.38 -0.25 -0.15 0.11]);%cancel
f=l;
n=l;
abar=toeplitz([a zeros(1,length(a)-2)],[a(1) zeros(1,length(a)-2)]);
bbar=toeplitz([b zeros(1,length(b)-2)], [b(1) zeros(1,length(b)-2)]);
dce=conv(d,l);
qbar=(dce(1,2:length(dce))-[a(1,2:length(a)) zeros(1,length(a)-1)])';
par=[abar bbar]\qbar;
g=[1 par(1:0.5*length(par))']
m=[0 par(0.5*length(par)+1:length(par))']
den=conv(a,conv(g,n))+[conv(b,conv(f,m))];
r2ynum=conv(n,conv(f,b));
r2unum=conv(f,conv(a,n));
w2ynum=-conv(b,conv(f,m));
w2unum=-conv(a,conv(f,m));
d2ynum=conv(b,conv(g,n));

subplot(211)
pzmap(r2ynum,den)
title('Pole Relocation Ex: Y/R Singularities')
subplot(212)
dstep(r2ynum,den)
title('Pole Relocation Ex: Y/R Step Response')
[ymax,x] = max(dstep(r2ynum,den))
sy = dstep(r2ynum,den);
final = sy(20)
figure(2)
dbode(r2ynum,den,1);
title('Pole Relocation Ex: Y/R Frequency Response')



figure(3)
subplot(211)
pzmap(r2unum,den)
title('Pole Relocation Ex: U/R Singularities')
subplot(212)
dstep(r2unum,den)
title('Pole Relocation Ex: U/R Step Response')
maxu = max(abs(dstep(r2unum,den)))

figure(4)
dbode(r2unum,den,1);
title('Pole Relocation Ex: U/R Frequency Response')
