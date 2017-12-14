%hw2_44
%Consider the stochastic augmented Lagrangian algorithm 
%covered in class with the power transmission control example. 
%Formulate the problem using reasonable parameters and simulate in Matlab. 
%Simulate the performance of the power transmission controller 
%in Matlab for di↵erent quality communication channels.


close all;
clear all;
clc
%x = exprnd(theta)
theta = 2;
d = 10;
mu = 0;
c = 0.01;
for k = 1:300
    th = theta(k);
    munow = mu(k);
    
    step = 1/10/k;
    xnow = exprnd(th);
    
    gradStep = 0.1/(1+k)^0.51;
    grad_xk = (exprnd(th + gradStep) - exprnd(th - gradStep))/2/gradStep;
    thetanext = th - step*(1+grad_xk*(munow + c * (xnow-d)));
    
    munext = max([munow + step * xnow],0);
    
    mu = [mu,munext];
    theta = [theta, thetanext];
end
figure,
plot(theta)