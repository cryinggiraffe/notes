
syms x;

f(x) = x^2+10*cos(x);

x0= pi*(3/4); %�ڶ���ȡ x0=pi*(5/4)
x=x0;
x0=x+1000*1e-6;
k=0;
while abs(x0-x)> 1e-6 & k<100
%�ж����͵�������
k=k+1
%�����������
x0=x;
y=f(x0);
z=f(y);
x=x0-(z-(z-y)^2/(z-2*y+x0));
x
end
if k==500
disp('�����������࣬��ֹ��ѭ����ֹ');
else
fprintf('������%d��ʱ�õ����%f\n',k,x)
end