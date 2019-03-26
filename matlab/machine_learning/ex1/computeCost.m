function J = computeCost(x, y, theta)
m = length(y); % number of training examples

J = 0;
J = x*theta-y;
J = (1/(2*m))*sum(J.*J);
end
