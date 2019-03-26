function p = predict( Theta1, Theta2, X )
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

m = size(X, 1);
num_labels = size(Theta2, 1);

p = zeros(size(X, 1), 1);


a1 = [ones(m,1) X];   %5000 * 401
z2 = a1 * Theta1';    %5000 * 25
a2_temp = sigmoid(z2);
a2 = [ones(m,1) a2_temp]; %5000 * 26
z3 = a2 * Theta2';
a3 = sigmoid(z3);  %   5000 * 10
[~,i] = max(a3,[],2);
p = i;             % 5000 * 1
end

