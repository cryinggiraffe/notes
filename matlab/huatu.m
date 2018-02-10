A=xlsread('第一问.xlsx',5);
for i=1:7
    B(i,:)=A(i,:);
end
B;
xlswrite('第二问.xlsx',B,1)