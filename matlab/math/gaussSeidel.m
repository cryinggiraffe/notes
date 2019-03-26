function [x,N] = gaussSeidel(A,b)

step = 0;
error = inf;
s = size(A);
D = zeros(s(1));
%vChain = zeros(15,3);

k = 1;
x0 = zeros(s(1),1);
x1 = x0;

for i = 1 : s(1)
    D(i,i) = A(i,i);
end

L = -tril(A,-1);
U = -triu(A,1);

while error >= 10^(-6)
    x0 = inv(D)*(L+U)*x0+inv(D)*b';
%    vChain(k,:) = x0';
    k = k+1;
    error = norm(x0-x1);
    x1 = x0;
    step = step + 1;
end

x = x0;
N = step;

