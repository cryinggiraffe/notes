file_h = fopen('Raw_Data.txt','a');
x = rand(3,500)*10;
fprintf(file_h,'%1.4f',X);
fwrite(file_h,X,'double');
fclose(file_h);
scatter(x(1,:),x(2,:))
%xlswrite('Random.xlsx',x,2)

% 近邻加权平均拟合法DEM内插

clear all; clc;clf;

% 实验参数
N = 500;  %实验数据点数
Delt = 1; %格网间隔
R = 1.^2; %近邻半径

% 生成实验数据
P = rand(3,N)*10;

%实验数据位置可视化
figure (1)
scatter(P(1,:),P(2,:))

% 根据实验数据生成格网
minx = round(min(P(1,:)))
maxx = round(max(P(1,:)))
DX = (maxx-minx)/Delt  %计算数据点X坐标的最小值和最大值以及X方向的格网数
miny = round(min(P(2,:))); maxy = round(max(P(2,:))); DY = (maxy-miny)/Delt;   %计算数据点X坐标的最小值和最大值以及X方向的格网数
X = linspace(minx,maxx,DX); %X方向网格坐标向量
Y = linspace(miny,maxy,DY); %Y方向网格坐标向量

[XX YY] = meshgrid(Y,X); %生成格网矩阵
DEM = zeros(DX,DY);  %
W_Sum = zeros(DX,DY);  %近邻点累积权重矩阵，目的是为了进行权的归一化

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     近邻加权平均拟合内插
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n = 1:N
    dst = (XX - P(1,n)).^2 + (YY - P(2,n)).^2;  %计算每个数据点与所有格网点的距离
    ind = find(dst < R);   %判断该数据点落在哪些格网点的邻域半径内
    DEM(ind) = DEM(ind) + P(3,n)./(dst(ind)+1);    %这里使用的权重为1/(1+d^2)
    W_Sum(ind) = W_Sum(ind) + 1./(dst(ind)+1);
end

ind = find(W_Sum> 0);
DEM(ind) = DEM(ind)./W_Sum(ind);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  插值结果可视化显示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
mesh(XX,YY,DEM)
title('近邻加权平均拟合法生成DEM模型');
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
title('近邻加权平均拟合法生成DEM模型');
xlabel('x');ylabel('y');zlabel('z');

figure(4)
contour(XX,YY,DEM,10)
