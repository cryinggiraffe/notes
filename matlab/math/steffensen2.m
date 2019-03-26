function[x_star,index,it]=steffensen2(phi,x,ep,it_max)  
%斯特芬森加速迭代方法  
% x为初始点  
% ep为精度，当| x(k)-x(k-1) |<ep时，终止计算，缺省值为1e-5  
% it_max为最大迭代次数  
% x_star为当迭代成功时，输出方程的根  
%   当迭代失败时，输出最后的迭代值;  
% index为指标变量，当index=1时，表明迭代成功  
% it为迭代次数  
if nargin<4 it_max=500;end  
if nargin<3 ep=10^(-7);end  
index=0;k=1;  
while k< it_max  
    x1=x;y=feval(phi,x);z=feval(phi,y);  
    x=x-(y-x)^2/(z-2*y+x);  
    if abs(x-x1)<ep  
        index=1;break;  
    end  
    k=k+1;  
end  
x_star=x;it=k;