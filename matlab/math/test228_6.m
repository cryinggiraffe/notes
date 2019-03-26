
%x0 = pi*(5/4);
x0 = 0.5
%fun = x^2+10*cos(x);
%phi=inline('x^2+10*cos(x)'); 
phi=inline('x^2-3*x-exp(x)+2'); 
[x_star,inedx,it] = steffensen2(phi,x0)

[x_star,k] = steffensen3(phi,x0)