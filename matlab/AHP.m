clear all
A=[1 1 1
   1 1 1
   1 1 1];

[m,n]=size(A);
[v,d]=eig(A);
r=d(1,1);
CI=(r-n)/(n-1);
RI=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.52 1.54 1.56 1.58 1.59];
CR=CI/RI(n);
if CR<0.10
    CR_Result='pass';
else
    CR_Result='no pass';
end

w=v(:,1)/sum(v(:,1));
w=w';

disp('���жϾ����Ȩ�������㱨�棺');
disp(['һ����ָ��:' num2str(CI)]);
disp(['һ���Ա�����' num2str(CR)]);
disp(['һ���Լ�������' CR_Result]);
disp(['����ֵ��' num2str(r)]);
disp(['Ȩ������' num2str(w)]);