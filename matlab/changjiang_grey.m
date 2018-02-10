clear all
clc
syms a b;
c=[a,b];
%A=[5530.7 5567.4 5497.3 5320.4 5547.8 5633.0 5795.0 5818.7 5910.0 5965.2 6022.0 6107.2 6141.8];
%A1=xlsread('1.xlsx',1);
A1=xlsread('T3.xlsx',1);
A0=A1(:,1);
%x0=x1';
%A=A1(31,:)
A=A0';
B=cumsum(A);
n=length(A)
for i=1:(n-1)
    C(i)=(B(i)+B(i+1))/2;
end

D=A;
D(1)=[];
D=D';

E=[-C;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);
b=c(2);

F=[];
F(1)=A(1);

for i=2:(n+13)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a;
end
G=[];
G(1)=A(1);
for i=2:(n+13)
    G(i)=F(i)-F(i-1);
end
t1=2000:2012;
t2=2000:2025;
G
a
b
plot(t1,A,'o',t2,G)
xlswrite('¹©Ë®.xlsx',G,1);