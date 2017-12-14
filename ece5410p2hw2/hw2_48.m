%hw2_48
%the toy queuing example considered in class. Simulate the optimal policy.
%Theorem (Bellman Stochastic Dynamic Programming alg)
%Jieneng Yang

clear all
clc;

NN = 100;
%Intailize: Optimal policy checklist Opt;
Opt = zeros(NN,16); %optimal lookup table
J = ones(NN+1,16); % the expected cumulative cost of the optimal policy

u = [0,0;1,0;2,0;3,0; % State set u(i,:) = [x1,x2]
    0,1;1,1;2,1;3,1;...
    0,2;1,2;2,2;3,2;...
    0,3;1,3;2,3;3,3]; % i = x1 + 1 + x2 * 4

c1 = 0.8; c2 = 1.5; %waiting time weight
mu1 = 0.3; mu2 = 0.25; %Service time for customer μ(i), arrival rate  (i), i = 1,2
lambda1 = 0.4; lambda2 = 0.45;

P11 = [1 - lambda1,lambda1,0,0;
       mu1,1-lambda1-mu1,lambda1,0;
       0,mu1,1-lambda1-mu1,lambda1;
       0,0,mu1,1-mu1];
P22 = [1 - lambda2,lambda2,0,0;
       mu2,1-lambda2-mu2,lambda2,0;
       0,mu2,1-lambda2-mu2,lambda2;
       0,0,mu2,1-mu2];
P12 = eye(4);
P21 = eye(4);
 
%cost function :cost = c1 * x1 + c2 * x2
%Terminal cost CN = c1 * x1 * (x1 + 1) / 2 + c2 * x2 *(x2 + 1)/2
for sta = 1:16
    x1 = u(sta,1);
    x2 = u(sta,2);
    J(NN+1,sta) = c1 * x1 * (x1 + 1) / 2 + c2 * x2 *(x2 +1)/2;
end

for k = NN:-1:1
    for sta = 1:16
        x1k = u(sta,1);
        x2k = u(sta,2);
        costK = c1 * x1k + c2 * x2k;
        acuCostSet1 = zeros(1,16); %Compute acumulate cost when act = 1
        for j = 1:16
            Pj = P11(x1k+1,u(j,1)+1) * P21(x2k+1,u(j,2)+1);%Independent
            acuCostSet1(j) = J(k+1,j) * Pj;
        end
        totalcost1 = costK + sum(acuCostSet1);
        
        acuCostSet2 = zeros(1,16); %Compute acumulate cost when act = 2
        for j = 1:16
            Pj = P12(x1k+1,u(j,1)+1) * P22(x2k+1,u(j,2)+1);
            acuCostSet2(j) = J(k+1,j) * Pj;
        end
        totalcost2 = costK + sum(acuCostSet2);
        
        if totalcost1 > totalcost2
            Opt(k,sta) = 2;
            J(k,sta) = totalcost2;
        else
            Opt(k,sta) = 1;
            J(k,sta) = totalcost1;
        end
                         
    end
end

figure(1),
%plot(Opt)

imagesc(Opt)
xlabel('state')
ylabel('time k')
colorbar%# Create a colored plot of the matrix values


    