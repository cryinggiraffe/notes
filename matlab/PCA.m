clear all
clc
A=xlsread('�����ѾƷ���.xlsx');

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

disp('����ֵ���乱�׶ȡ��ۼƹ��׶ȣ�')
DS
%xlswrite('�����ѾƷ���.xlsx',DS,2);
disp('��Ϣ�����ʶ�Ӧ�����ɷ���������������')
Com_num
PV
disp('���ɷֵ÷�����')
result_report
xlswrite('�����ѾƷ���.xlsx',result_report,3);