function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));


n=size(theta);
y1 = sigmoid(X*theta);
J = 1/m * sum( -y.*log(y1) - (1.-y).*log(1.-y1) ) +(lambda / (2*m))*sum(theta.*theta);
J = J-(lambda / (2*m))*theta(1)^2;
%grad
grad(1) = (1/m)*sum( (y1-y).*X(:,1) );
for i=2:n
    grad(i) = (1/m)*sum( (y1-y).*X(:,i) ) + (lambda /m)*theta(i) ;
end

end
