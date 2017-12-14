clear all
clc;

Y = laprnd(10, 100, 0, 1);

W = eye(10);  %initail  W
alpha = 0.5; % α is the learning rate.

%y = sigmf(x,[1 0]) sigmoid



for ind = 1:100
    wy = W * Y(:,ind);
    matrixStep = (ones(10,1) - 2 * sigmf(wy,[1 0])) * Y(:,ind)' + inv(W');
    W = W + matrixStep * alpha;
end

X = W * Y;
figure,
for i = 1:5
    subplot(5,1,i)
    plot(X(i+5,:))
end
    

