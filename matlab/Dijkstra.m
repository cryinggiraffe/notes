clear all;close all;clc
%初始化邻接压缩表，1 2 10 表示从节点1到节点2，边的权重为10
b=[1 2 10;1 4 5;2 3 1;
4 2; 3 5 4;4 2 3;
3 9; 4 5 2;5 1 7;
3 6];

m=max(max(b(:,1:2)));       %压缩表中最大值就是邻接矩阵的宽与高
A=compresstable2matrix(b);  %从邻接压缩表构造图的矩阵表示
netplot(A,1)                %形象表示

S=inf(1,m);         %从开始的源点到每一个节点的距离
S(1)=0;             %源点到自己的距离为0
pa=zeros(1,m);      %存储每个节点的前驱，在松弛过程中赋值
pa(1)=1;            %源点的前趋是自己　

visit=zeros(1,m);   %标记某个节点是否访问过了
index=1;            %从index节点开始搜索        

%判断是否对所有节点都找的最短路径了。可能会有源点没有路径到目标节点的情况，那就无限循环了
while sum(visit)~=m    %没有出队列操作，不过通过visit来等价的表示了
    
    visit(index)=1;                     %标记第index节点为已入列的节点
    [S pa]=relax(S,pa,A,visit,index,m);         %松弛，如果两个节点间有更短的距离，则用更短的距离
    index=extract_min(S,visit,index,m); %使用已访问的最小的节点作为下一次搜索的开始节点  

end
%最终我们需要的就是这两个值
S       %源点到其他每一点的距离
pa      %其他每一节点的前趋

%算法到此结束，下面只是为了形象的表示而写的。
re=[];
for i=2:m
    re=[re;pa(i) i A(pa(i),i)];
end
A=compresstable2matrix(re);  %从邻接压缩表构造图的矩阵表示
figure;
netplot(A,1)                %形象表示