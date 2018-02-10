file_h = fopen('Raw_Data.txt','a');
x = rand(3,500)*10;
fprintf(file_h,'%1.4f',X);
fwrite(file_h,X,'double');
fclose(file_h);
scatter(x(1,:),x(2,:))
%xlswrite('Random.xlsx',x,2)

% ���ڼ�Ȩƽ����Ϸ�DEM�ڲ�

clear all; clc;clf;

% ʵ�����
N = 500;  %ʵ�����ݵ���
Delt = 1; %�������
R = 1.^2; %���ڰ뾶

% ����ʵ������
P = rand(3,N)*10;

%ʵ������λ�ÿ��ӻ�
figure (1)
scatter(P(1,:),P(2,:))

% ����ʵ���������ɸ���
minx = round(min(P(1,:)))
maxx = round(max(P(1,:)))
DX = (maxx-minx)/Delt  %�������ݵ�X�������Сֵ�����ֵ�Լ�X����ĸ�����
miny = round(min(P(2,:))); maxy = round(max(P(2,:))); DY = (maxy-miny)/Delt;   %�������ݵ�X�������Сֵ�����ֵ�Լ�X����ĸ�����
X = linspace(minx,maxx,DX); %X����������������
Y = linspace(miny,maxy,DY); %Y����������������

[XX YY] = meshgrid(Y,X); %���ɸ�������
DEM = zeros(DX,DY);  %
W_Sum = zeros(DX,DY);  %���ڵ��ۻ�Ȩ�ؾ���Ŀ����Ϊ�˽���Ȩ�Ĺ�һ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     ���ڼ�Ȩƽ������ڲ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n = 1:N
    dst = (XX - P(1,n)).^2 + (YY - P(2,n)).^2;  %����ÿ�����ݵ������и�����ľ���
    ind = find(dst < R);   %�жϸ����ݵ�������Щ�����������뾶��
    DEM(ind) = DEM(ind) + P(3,n)./(dst(ind)+1);    %����ʹ�õ�Ȩ��Ϊ1/(1+d^2)
    W_Sum(ind) = W_Sum(ind) + 1./(dst(ind)+1);
end

ind = find(W_Sum> 0);
DEM(ind) = DEM(ind)./W_Sum(ind);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  ��ֵ������ӻ���ʾ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
mesh(XX,YY,DEM)
title('���ڼ�Ȩƽ����Ϸ�����DEMģ��');
xlabel('x');ylabel('y');zlabel('z');

figure(3)
surf(XX,YY,DEM);
% shading interp
view(-50,70)
axis([minx maxx miny maxy 0 9])
% colormap(gray)
% shading interp
% colorbar;
% set(gca,'YDir','reverse');
title('���ڼ�Ȩƽ����Ϸ�����DEMģ��');
xlabel('x');ylabel('y');zlabel('z');

figure(4)
contour(XX,YY,DEM,10)
