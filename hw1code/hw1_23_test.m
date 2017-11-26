clc;
clear;
p=1;
T = 300;
a0 = 0.1; a1 = 0.1; 
seed=123;
ra = randn(T+2000,1); 
epsi = zeros(T+2000,1);
simsig = zeros(T+2000,1);
unvar = a0/(1-a1);
for i = 1:T+2000
                 if (i==1) 
                     simsig(i) = unvar;
                     s=(simsig(i))^0.5;
                     epsi(i) = ra(i) * s;
                   else                     
                       simsig(i) = a0+ a1*(epsi(i-1))^2;
                       s=(simsig(i))^0.5;
                       epsi(i) = ra(i)* s;
                   end
  end
epsi2 = epsi.^2;
y = epsi2(2001:T+2000); % THIS IS THE DATA SET I WANT TO TEST. 
len = length(y);
x = zeros(len,p);
for i = 1:p
       x(1+i:len,i) = y(1:len-i,1);  % THIS IS THE x VECTOR
end
       N=length(x);
       e=ones(N,1);
       f=[0,0,e.'];
       A=[x(:),e,-speye(N);-x(:), -e, -speye(N)];
       b=[y(:);-y(:)];
       lb=zeros(N+2,1);
       ub=inf(N+2,1); ub(1)=1;
       %%Perform fit and test
       p=linprog(f,A,b,[],[],lb,ub);
       slope=p(1),
       intercept=p(2),