A=xlsread('��һ��.xlsx',5);
for i=1:7
    B(i,:)=A(i,:);
end
B;
xlswrite('�ڶ���.xlsx',B,1)