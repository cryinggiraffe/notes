function [theta, J_history] = gradientDescent(x, y, theta, alpha, num_iters)
m = length(x);
J_history = zeros(num_iters, 1);
J = zeros(m,1);

%迭代次数
for i = 1 : num_iters
    J = x*theta - y;
    temp1 = theta(1) - alpha*(1/m)*sum(J.*x(:,1));
    temp2 = theta(2) - alpha*(1/m)*sum(J.*x(:,2));
    theta(1) = temp1;
    theta(2) = temp2;
    
    % Save the cost J in every iteration
    % 计算了num_iters次的cost
    J_history(i) = computeCost(x,y,theta);
    
end
