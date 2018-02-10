clear all 
clc
a=0.95;
%物品的价值
k=[5;10;13;4;3;11;13;10;8;16;7;4];
k=-k;
%物品的质量
d=[2;5;18;3;2;5;10;4;11;7;14;6];
%背包的最大允许质量
restriction=46;
%物品的个数
num=12;
sol_new=ones(1,num);
%E_current当前解对应的目标函数值，即背包中物品的总价值
E_current=inf;
%E_best是最优解
%E_new是新解的目标函数值
E_best=inf;
sol_current=sol_new;
sol_best=sol_new;
t0=97;
tf=3;
t=t0;
p=1;

while t>=tf
    for r=1:100
        %产生随机扰动
        tmp=ceil(rand.*num);
        sol_new(1,tmp)=~sol_new(1,tmp);
        %检查是否满足约束
        while 1
            q=(sol_new*d<=restriction);
            if ~q
                p=~p;
                tmp=find(sol_new==-1);
                if p
                    sol_new(1,tmp)=0;
                else
                    sol_new(1,tmp(end))=0;
                end
            else
                break
            end
        end
        
        %计算背包中的物品价值
        E_new=sol_new*k;
        if E_new<E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new<E_best
                %把冷却过程中最好的解保存下来
                E_best=E_new;
                sol_best=sol_new;
            end
        else
            if rand<exp(-(E_new-E_current)./t)
                E_current=E_new;
                sol_current=sol_new;
            else
                sol_new=sol_current;
            end
        end
    end
    t=t.*a;
end

disp('最优解：')
sol_best
disp('物品最价值为：')
val=-E_best;
disp(val)
disp('背包中物品重量：')
disp(sol_best*d)