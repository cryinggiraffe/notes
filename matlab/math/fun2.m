function [f,J] = fun2(x)
f = x.^2 + 10 * cos(x);
J = diff(f);
end

