function[x_star,index,it]=steffensen2(phi,x,ep,it_max)  
%˹�ط�ɭ���ٵ�������  
% xΪ��ʼ��  
% epΪ���ȣ���| x(k)-x(k-1) |<epʱ����ֹ���㣬ȱʡֵΪ1e-5  
% it_maxΪ����������  
% x_starΪ�������ɹ�ʱ��������̵ĸ�  
%   ������ʧ��ʱ��������ĵ���ֵ;  
% indexΪָ���������index=1ʱ�����������ɹ�  
% itΪ��������  
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