%rlbd
       %root locus based design
       
       clear clf
       %pick/confirm the following variables
       b=0.08*[1 0.7]; %plant numerator
       a=conv([1 -1],[1 -0.5]); %plant denominator
       f=[1 -0.5]; %compensator numerator
       g=[1 0.1]; %compensator denominator
       its=15; %number of iterations for test response window
       %%%%%%%%%%%%%%%%%%%%%%%%
       figure(1)
       subplot(111)
       rlocus(conv(b,f),conv(a,g))
       
       [gain,poles]=rlocfind(conv(b,f),conv(a,g))
       pause
       ff=gain*f;
       figure(2)
       rynum=conv(b,ff);
       ryden=conv(a,g)+[0 conv(b,ff)];
       subplot(221)
       [sy,sx]=dstep(rynum,ryden,its);
       plot(sy)
       ylabel('Amplitude')
       xlabel('No. of Samples')
       title ('(a) Y/R step response')
       maxy=max(dstep(rynum,ryden))
       subplot(222)
       ht=[floor(its/2):its];
       plot(ht,ones(size(sy(ht(1):its)))-sy(ht(1):its))
       ylabel('Amplitude')
       xlabel('No. of Samples')
       title('(b) Step tracking error')
       
       subplot(223)
       ramp=[0.01:0.01:.3];
[ry,rx]=dlsim(rynum,ryden,ramp);
plot(ht,ramp(ht(1):its)-ry(ht(1):its)')
ylabel('Amplitude')
       
xlabel('No. of Samples')
title('(c) Ramp tracking error')
       subplot(224)
       runum=conv(ff,a);
       ruden=ryden;
       [yy,xx]=dstep(runum,ruden,its);
       plot(yy)
       title('(d) U/R step response')
       maxu=max(dstep(runum,ruden,its))
       ylabel('Amplitude')
       xlabel('No. of Samples')