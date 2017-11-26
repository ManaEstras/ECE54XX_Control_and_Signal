%svfd
%state variable feedback design
%exam2_a Jieneng Yang
clf, clear, hold off

A=[0.7 -0.2 0 0.3;0 0.8 0.3 -0.4;-0.1 0.3 0 -0.2;0.2 -0.2 0.9 0.8];
b=[0.11; -0.04; 0.08;0];
c=[0.5 -2 0 3];
d=0;
ii = sqrt(-1);
dp=[0.6 + 0.15 * ii, 0.6 - 0.15 * ii, 0.2, 0.3];
xhat = zeros(4,10);
dp2 = [0.5 0.3 0.1 0.05];


k=place(A,b,dp)

figure(1)
subplot(221)
pzmap(A,b,c,d)
title('Plant singularities')
subplot(222)
pzmap(A-b*k,b,c,d)
title('Achieved singularities')
subplot(223)
[y,x,t]=dstep(A-b*k,b,c,d,1);
dstep(A,b,c,d,1,t)
title('Plant step response')
subplot(224)
dstep(A-b*k,b,c,d,1,t)
title('Achieved step response')
max(y)

