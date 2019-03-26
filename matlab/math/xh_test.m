
syms x;

f(x) = x^2+10*cos(x);

x0= pi*(3/4); %第二次取 x0=pi*(5/4)
x=x0;
x0=x+1000*1e-6;
k=0;
while abs(x0-x)> 1e-6 & k<100
%判断误差和迭代次数
k=k+1
%计算迭代次数
x0=x;
y=f(x0);
z=f(y);
x=x0-(z-(z-y)^2/(z-2*y+x0));
x
end
if k==500
disp('迭代次数过多，防止死循环终止');
else
fprintf('迭代到%d次时得到结果%f\n',k,x)
end