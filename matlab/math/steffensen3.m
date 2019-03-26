function [ x_star,k] = steffensen3( fun,x0,ep,Nmax)
if nargin<4 Nmax=500;end  
if nargin<3 ep=10^(-7);end

x = x0;
y = feval(fun,x0);
z = feval(fun,y);
x0 = x + 2*ep;
k = 0;

while abs(x0 - x) > ep & k < Nmax
    x = x0;
    y = feval(fun,x0);  
    z = feval(fun,y); 
    x0=x0-(y-x0)^2/(z-2*y+x0); 
    k=k+1;
end

x_star = x ;

if k == Nmax  
    warn('..');
end
end 