A=xlsread('1.xlsx',3);
[m,n]=size(A);
for i=1:m-1
    for j=1:n-1
        X(i,j)=A(i,j+1)/A(i,j)-1;
    end
end
xlswrite('1.xlsx',X,4)