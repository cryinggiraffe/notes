%��Ե�ɳڣ�ʹ�ø��̵ľ�����Ϊ�ڵ��ֵ
function [S pa]=relax(S,pa,A,visit,index,m)
   
   i=index;
   for j=1:m
        if A(i,j)~=inf && visit(j)~=1   %����û�б�ǹ��Ľڵ�
            if S(j)>S(i)+A(i,j)         %����С��ֵ����������Ѱ�Ľڵ�
                S(j)=S(i)+A(i,j);
                pa(j)=i;
            end
        end        
    end    

end