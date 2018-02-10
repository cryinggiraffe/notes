clear all
clc
%原始数据
sqrs=[20.55 22.44 25.37 27.13 29.45 30.10 30.96 34.06 36.42 38.09 39.13 39.99 41.93 44.59 47.30 52.89 55.73 56.76 59.17 60.63];
sqjdcs=[0.6 0.75 0.85 0.9 1.05 1.35 1.45 1.6 1.7 1.85 2.15 2.2 2.25 2.35 2.5 2.6 2.7 2.85 2.95 3.1];
sqglmj=[0.09 0.11 0.11 0.14 0.20 0.23 0.23 0.32 0.32 0.34  0.36 0.36 0.38 0.49 0.56 0.59 0.59 0.67 0.69 0.79];
glkyl=[5126 6217 7730 9145 10460 11387 12353 15750 18304 19836 21024 19490 20433 22598 25107 33442 36836 40548 24927 43462];
glhyl=[1237 1379 1385 1399 1663 1714 1834 4322 8132 8936 11099 11203 10523 11115 13320 16762 18673 20724 20803 21804];
%输入数据矩阵
p=[sqrs;sqjdcs;sqglmj];
%目标数据矩阵
t=[glkyl;glhyl];
%归一化
[pn,input_str]=mapminmax(p);
[tn,output_str]=mapminmax(t);

%建立BP网络
net=newff(pn,tn,[3 7 2],{'purelin','logsig','purelin'});
%10轮回显示一次结果
net.trainParam.show=10;
%学习速度
net.trainParam.lr=10;
%最大训练次数
net.trainParam.epochs=5000;
%均方差
net.trainParam.goal=0.65*10^(-3);
%默认迭代6次训练没有变化结束，可以取消
net.divideFcn='';
%开始训练，pn和tn分别为输入输出样本
net=train(net,pn,tn);
%利用训练好的网络
an=sim(net,pn);
a=mapminmax('reverse',an,output_str);
x=1990:2009;
newk=a(1,:);
newh=a(2,:);
figure(2);
%绘制公路客运量对比图
subplot(2,1,1);
plot(x,newk,'r-o',x,glkyl,'b--+')
legend('网络输出客流量','实际客流量');
xlabel('年份');
ylabel('客运量/万人');
title('运用工具箱客运量学习和测试对比图');
subplot(2,1,2);
plot(x,newh,'r-o',x,glhyl,'b--+')
legend('网络输出货运量','实际货运量');
xlabel('年份');
ylabel('货运量/万人');
title('运用工具箱货运量学习和测试对比图');