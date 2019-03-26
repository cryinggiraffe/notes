function [f,J] = fun1(x)
 f = x - (2 - exp(x) + x.^2)/3;
 J = diff(f);
end

