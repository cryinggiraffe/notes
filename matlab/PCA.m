clear all
clc
A=xlsread('白葡萄酒分析.xlsx');

a=size(A,1);
b=size(A,2);
for i=1:b
    SA(:,i)=(A(:,i)-mean(A(:,i)))/std(A(:,i));
end

CM=corrcoef(SA);
[V,D]=eig(CM);
for j=1:b
    DS(j,1)=D(b+1-j,b+1-j);
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1));
    DS(i,3)=sum(DS(1:i,1)/sum(DS(:,1)));
end

T=0.9;
for K=1:b
    if DS(K,3)>=T
        Com_num=K;
        break;
    end
end

for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end

new_score=SA*PV;
for i=1:a
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
result_report=[new_score,total_score];
result_report=sortrows(result_report,-5);

disp('特征值及其贡献度、累计贡献度：')
DS
%xlswrite('白葡萄酒分析.xlsx',DS,2);
disp('信息保留率对应的主成分数与特征向量：')
Com_num
PV
disp('主成分得分排序：')
result_report
xlswrite('白葡萄酒分析.xlsx',result_report,3);