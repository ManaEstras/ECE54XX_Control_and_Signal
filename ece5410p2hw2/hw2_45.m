%Jieneng Yang 
%draws 2 dimensional LMS on contour plot
%draws 2 dimensional RLS on contour plot


close all
clear all

%Prompts for plant parameters in b0*u(k)+b1*u(k-1)
b0=2* rand;
b1=2* rand;

%Prompts for input descriptors: u =g1*sin(om1*i)+g2*sin(om2*i)
%plus binary noise +/-bicm
g1=2;
om1=0.3;
g2=1.4;
om2=1.8;
bicm=1;
omng=0.02;

%parameter space plot limits
blim=max([abs(2*b0),abs(2*b1),2]);
[XX,YY]=meshgrid(-blim:blim/20:blim,-blim:blim/20:blim);

%error surface plot
t1=b0-XX;
t2=b1-YY;
MM1=0.5*(g1^2+g2^2)+bicm^2;
MM2=0.5*(cos(om1)*g1^2+cos(om2)*g2^2);
z=MM1.*((t1.^2)+(t2.^2))+2*MM2.*t1.*t2;
MM=[MM1 MM2; MM2 MM1];
[mmv,mmd]=eig(MM); %eigenvectors and eigenvalues of avg(XX^T)
figure(1)
contour([-blim:blim/20:blim],[-blim:blim/20:blim],z,20)
xlabel('b0')
ylabel('b1')
title('Adaptive (solid) and Average (dashed) Parameter Trajectories')
axis equal
axis square
hold on

%Prompts for LMS simulation run
itno=5000;
b0hat=zeros(1,itno+1);
b1hat=zeros(1,itno+1);
btilav=zeros(2,itno+1);
bav=zeros(2,itno+1);

mu=0.05;

b0hat(2)= -1 + rand;
b1hat(2)= -1 + rand;
btilav(:,2)=[b0-b0hat(2); b1-b1hat(2)];
bav(:,2)=[b0hat(2); b1hat(2)];

b0hatRLS=zeros(1,itno+1);
b1hatRLS=zeros(1,itno+1);
b0hatRLS(2)= b0hat(2);
b1hatRLS(2)= b1hat(2);

%create input vector
%for ind=1:itno+1,
%u(ind)=g1*sin(om1*(ind-1))+g2*sin(om2*(ind-1))+bicm*sign(rand-.5);
%end

u = normrnd(0,1,[1 itno+1])
P = zeros(itno+1,2,2);
P(1,:,:) = eye(2);
P(2,:,:) = [1,0.6;1,10];

%simulation loop
for ind=2:itno,
    y = b0*u(ind)+b1*u(ind-1)+omng*2*(rand-.5);
    yhat=b0hat(ind)*u(ind)+b1hat(ind)*u(ind-1);
    e = y - yhat;
    b0hat(ind+1)=b0hat(ind)+mu*e*u(ind);
    b1hat(ind+1)=b1hat(ind)+mu*e*u(ind-1);
    btilav(:,ind+1)=(eye(size(MM))-mu*MM)*btilav(:,ind);
    bav(:,ind+1)=[b0; b1]-btilav(:,ind+1);
    
    yhatRLS=b0hatRLS(ind)*u(ind)+b1hatRLS(ind)*u(ind-1);
    eRLS = y - yhatRLS;
    Fi = [u(ind),u(ind-1)]';
    Pn = reshape(P(ind,:,:),[2,2]);
    dino = 10 + Fi'*Pn*Fi;
    gainRLS = Pn * Fi ./ dino;
    b0hatRLS(ind+1)=b0hat(ind) + gainRLS(1) * eRLS;
    b1hatRLS(ind+1)=b0hat(ind) + gainRLS(2) * eRLS;
    P(ind + 1,:,:) = Pn - Pn*Fi*Fi'*Pn./dino;
end

%plot adapted and average parameter trajectory
plot(b0hat(2:itno+1),b1hat(2:itno+1))
plot(b0hatRLS(2:itno+1),b1hatRLS(2:itno+1),'g')
plot(bav(1,2:itno+1),bav(2,2:itno+1),':')



hold off
