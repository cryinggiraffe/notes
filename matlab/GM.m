clear all;
clc;

x0=[92.810 97.660 98.800 99.281 99.537 99.537 99.817 100.000];

n=length(x0);

lamda=x0(1:n-1)./x0(2:n);
range=minmax(lamda)

if range(1,1)<exp(-(2/(n+2))) | range(1,2)>exp(2/(n+2))
    error('����û�������ɫģ�ͷ�Χ');
else
    disp('����GM��1��1��ģ��');
end