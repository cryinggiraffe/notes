syms x;
%f(x) = x^2+10*cos(x);
f(x) = x - (2 - exp(x) + x.^2)/3;
fun = @(x)f(x);
f(x)= diff(f(x));
dfun=@(x)f(x);
%���㵼����
syms x0;
syms k;
%x0= pi*(3/4); 
%�ڶ���ȡ 
%x0=pi*(5/4)
x0 = 0.5;
x=x0;
x0=x+1000*1e-6;
k=0;
while abs(x0-x)> 1e-6 & k<100
%�ж����͵�������
k=k+1
%�����������
x0=x;
x=x0-feval(fun,x0)/feval(dfun,x0);
x
end
if k==500
disp('��ѭ����ֹ');
else
fprintf('������%d��ʱ�õ����%f\n',k,x)
end
