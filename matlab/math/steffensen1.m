function [ gen,time ] = steffensen1( fun , x0, tol )
if nargin == 2
    tol = 1.0^(-6);
end

time = 0;
esp = 0.1;
gen = x0;

while esp > tol
    x1 = gen;
    y = subs(fun,x1) + x1;
    z = subs(fun,y) + y;
    
    gen = x1 - (y-x1)^2/(z-2*y+x1);
    esp = abs(gen-x1);
    time = time+1;
end
