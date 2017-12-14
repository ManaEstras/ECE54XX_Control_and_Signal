%HW2_43_
%portfolio & primal dual algorithm
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

w = ones(10,1);
z = ones(10,1);
lam = zeros(2,1);
mu = zeros(10,1);
k = 1;
dist = 100;
while dist(k)>0.1
    k = k + 1;
    step = 10/k;
    wnow = w(:,k-1);
    znow = z(:,k-1);
    lamnow = lam(:,k-1);
    munow = mu(:,k-1);
    
    wnext = wnow - step * (2 * R * wnow + H * lamnow);
    znext = znow - step * (2 * munow .* znow);
    lamnext = lamnow - step * [wnow' * r - rsum; wnow' * sig - 1];
    munext = munow - step * (-wnow + znow.*znow);
    
    dist = [dist,norm(wnow - wnext,2)];
    
    w = [w,wnext];
    z = [z,znext];
    lam = [lam,lamnext];
    mu = [mu,munext];
    if k > 50000 break; 
    end
end

finaldist = dist(k);
sum(wnext)

figure,
plot(dist)