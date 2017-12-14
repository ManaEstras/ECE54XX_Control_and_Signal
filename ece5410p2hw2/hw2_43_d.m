%HW2_43_d
%portfolio & primal dual algorithm
%Augmented Lagrangian
clear all
close all
clc;

%Construct the covariance of matrix R and mean r
A = 5 * rand(10);
R = (A'+ A)/10;
[n,m]=size(A);
R(1:n+1:end)=diag(A);
r = rand(10,1);
r = r./sum(r);
rsum = 1;
sig = ones(10,1);
H = [r,sig];

w = zeros(10,1);
w(1) = 1;
%z = ones(10,1);
lam = zeros(3,1);
%mu = zeros(10,1);
k = 1;
dist = 100;
rou = 0.1;
for k = 2:100
    step = 1/2/k;
    wnow = w(:,k-1);
    lamnow = lam(:,k-1);
    H = [r,sig,2*wnow]
    
    wnext = wnow - step * (2 * R * wnow + H * lamnow ...
   + rou *((wnow'*r - rsum)*r + (wnow'*sig - 1) * sig + (wnow'*wnow - 1) * wnow));
    lamnext = lamnow - step * [wnow' * r - rsum; wnow' * sig - 1;wnow'*wnow - 1];
    
    dist = [dist,norm(wnow - wnext)];
    
    w = [w,wnext];
    lam = [lam,lamnext];
end

finaldist = dist(k);
sum(wnext)

figure,
plot(dist)