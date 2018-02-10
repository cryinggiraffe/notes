clear all;
close all;
clc;
%算法导论P349的列子
G=[0 4 0 0 0 0 0 8 0;
0 8 0 0 0 0 11 0;
8 0 7 0 4 0 0 2;
0 7 0 9 14 0 0 0;
0 0 9 0 10 0 0 0;
0 4 14 10 0 2 0 0;
0 0 0 0 2 0 1 6;
11 0 0 0 0 1 0 7;
0 2 0 0 0 6 7 0];

[m n]=size(G);
E=[];
k=0;    %边的数量
for i=1:m
    for j=i:n
        if G(i,j)~=0
            E=[E;G(i,j) i j];   %提取边，三元组存储
            k=k+1;
        end
    end
end

for i=k:-1:1                %按边的权重排序，小的排前面
    for j=1:i-1
        if E(j,1)>E(j+1,1)
            tmp=E(j,:);
            E(j,:)=E(j+1,:);
            E(j+1,:)=tmp;
        end
    end
end

A=zeros(m,n);
for i=1:k  
    A(E(i,2),E(i,3))=E(i,1);
    A(E(i,3),E(i,2))=E(i,1);
    if huan(A)              %加入边后判断图中是否含有环
        A(E(i,2),E(i,3))=0;
        A(E(i,3),E(i,2))=0;
    end
end