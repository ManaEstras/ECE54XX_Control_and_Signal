%hw2_28
%hw_28
%Illustrate via Matlab simulation how this variance estimate is
%affected when constraints of the form A✓ = 0 are added to the least squares
%formulation.
%Jieneng Yang

clear all
theta_o=10*rand(5,1);
sigma=3;
N=100;
n=length(theta_o);
V=normrnd(0,2,(N-n+1),1);
u=randn(1,N);
% predict the optimal theta
psi=toeplitz(u(n:N),u(n:-1:1));
Y=psi*theta_o+V;
theta_pre=(psi'*psi)\psi'*Y;
sigma2_unbiased=(1/(N-n+1))*(Y-psi*theta_pre)'*(Y-psi*theta_pre);
display('The predicted variance without constrant is (variance 9):');
sigma2_unbiased
% add the constraint
A=[1,0,0,0,0; 0,1,0,0,0];
I=eye(length(theta_o));
theta_cons=(I-A'*inv(A*A')*A)*theta_pre;
sigma2_biased=(1/(N-n+1))*(Y-psi*theta_cons)'*(Y-psi*theta_cons);
display('The predicted variance with constrant is (variance is 9):');
sigma2_biased