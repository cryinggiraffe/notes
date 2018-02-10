%边缘松弛，使用更短的距离作为节点的值
function [S pa]=relax(S,pa,A,visit,index,m)
   
   i=index;
   for j=1:m
        if A(i,j)~=inf && visit(j)~=1   %搜索没有标记过的节点
            if S(j)>S(i)+A(i,j)         %将较小的值赋给正在搜寻的节点
                S(j)=S(i)+A(i,j);
                pa(j)=i;
            end
        end        
    end    

end