%   Jieneng Yang jy762
% 1(g)

N = 0.7 * [0 0 1 -0.65 -1.57];
D = [1 -1.7 0.75 0.031 -0.039];
[sx,sy] = dstep(N,D,100);
figure(1),
plot(sx)
ylabel('Amplitude')
xlabel('No. of Samples')
title ('step response')


% 1(h)
[H,w]=freqz(N,D,1024,'whole');
Hf=fftshift(abs(H));
Hx=fftshift(angle(H));
figure(2),
plot(w,Hf)
title('Freq Res Abs')
figure(3)
plot(w,Hx/pi*180)
title('Freq Res Phase')
xlabel('radian/sample')

% 1(i)
figure(4),
rlocus(N,D)
[gain,poles]=rlocfind(N,D)
pause
rynum = N;
ryden = D + gain * N;
[sy,sx]=dstep(rynum,ryden,100);
figure(5)
plot(sy)
ylabel('Amplitude')
xlabel('No. of Samples')
title ('(a) Y/R step response')