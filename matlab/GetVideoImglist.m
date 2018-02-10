function [nFrames]=GetVideoImglist(videoFilePath)
%��ȡ��Ƶͼ������
%���������
%videoFilePath--��Ƶ·����Ϣ
%�������
%videoImglist--��Ƶͼ������

xyloObj=VideoReader(videoFilePath);
%��Ƶ��Ϣ
nFrames=xyloObj.NumberOfFrames;
video_imagesPath=fullfile(pwd,'video_images');
if ~exist(video_imagesPath,'dir')
   mkdir(video_imagesPath);
end
%����Ƿ������
files=dir(fullfile(video_imagesPath,'*.jpg'));
if length(files)==nFrames
    return;
end
%��������ʾ��
h=waitbar(0,'','Name','��ȡ��Ƶͼ������...');
steps=nFrames;
for step=1:nFrames
    %��ȡͼ��
    temp=read(xyloObj,step);
    %�Զ�����
    temp_str=sprintf('%s\\%03d.jpg',video_imagesPath,step);
    imwrite(temp,temp_str);
    %��ʾ����
    pause(0.01);
    waitbar(step/steps,h,sprintf('�Ѵ���%d%',round(step/nFrames*100)));
end
close(h)
end