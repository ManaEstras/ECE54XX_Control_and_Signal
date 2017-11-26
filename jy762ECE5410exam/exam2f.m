%Jieneng Yang
%2(f)

clear all;
clc

a = 1.32;b = 0.4;c = 0.7;
f = 1.775;g = 1.785894;

N = [0 g*b*c 0];
D = [1 (-1-a+f*b+g*b*c) a-f*b];

figure(1)
pzmap(N,D)

its = 100;
figure(2)
rynum=N;
ryden=D
subplot(221)
[sy,sx]=dstep(rynum,ryden,its);
plot(sy)
ylabel('Amplitude')
xlabel('No. of Samples')
       title ('(a) Y/R step response')
       maxy=max(dstep(rynum,ryden))
       persentovershoot = (maxy - sy(99)) / sy(99) * 100
       subplot(222)
       ht=[floor(its/2):its];
       plot(ht,ones(size(sy(ht(1):its)))-sy(ht(1):its))
       ylabel('Amplitude')
       xlabel('No. of Samples')
       title('(b) Step tracking error')
       
       subplot(223)
       ramp=[0.01:0.01:0.01 * its];
[ry,rx]=dlsim(rynum,ryden,ramp);
plot(ht,ramp(ht(1):its)-ry(ht(1):its)')
ylabel('Amplitude')
       
xlabel('No. of Samples')
title('(c) Ramp tracking error')
       subplot(224)
       runum= g * [1 -(a+1) a];
       ruden= D;
       [yy,xx]=dstep(runum,ruden,its);
       plot(yy)
       title('(d) U/R step response')
       maxu=max(dstep(runum,ruden,its))
       ylabel('Amplitude')
       xlabel('No. of Samples')