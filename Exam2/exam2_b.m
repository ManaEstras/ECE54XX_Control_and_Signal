%svfd
%state variable feedback design
%exam2_a Jieneng Yang
clf, clear

A=[0.7 -0.2 0 0.3;0 0.8 0.3 -0.4;-0.1 0.3 0 -0.2;0.2 -0.2 0.9 0.8];
b=[0.11; -0.04; 0.08;0];
c=[0.5 -2 0 3];
d=0;
ii = sqrt(-1);
xhat = zeros(4,10);
dp2 = [0.5 0.3 0.1 0.05];
x = zeros(4,10);
x(:,1) = [2; -0.5; 0;-1];
xhat(:,1) = [0;0;0;0];
xerr = x - xhat;
xtx = zeros(1,10);
xtx(1) = xerr(:,1)' * xerr(:,1);
u = [0.5 * ones(1,3) ones(1,10)];

l = place(A',c',dp2)'
for i = 1:8
    xerr(:,i+1) = (A - l*c)* xerr(:,i);
    xtx(i+1) = xerr(:,i+1)' * xerr(:,i+1);
end

figure(1)
plot(xtx)