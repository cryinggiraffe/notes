function [nFrames]=GetVideoImglist(videoFilePath)
%获取视频图像序列
%输入参数：
%videoFilePath--视频路径信息
%输出参数
%videoImglist--视频图像序列

xyloObj=VideoReader(videoFilePath);
%视频信息
nFrames=xyloObj.NumberOfFrames;
video_imagesPath=fullfile(pwd,'video_images');
if ~exist(video_imagesPath,'dir')
   mkdir(video_imagesPath);
end
%检查是否处理完毕
files=dir(fullfile(video_imagesPath,'*.jpg'));
if length(files)==nFrames
    return;
end
%进度条提示框
h=waitbar(0,'','Name','获取视频图像序列...');
steps=nFrames;
for step=1:nFrames
    %提取图像
    temp=read(xyloObj,step);
    %自动保存
    temp_str=sprintf('%s\\%03d.jpg',video_imagesPath,step);
    imwrite(temp,temp_str);
    %显示进度
    pause(0.01);
    waitbar(step/steps,h,sprintf('已处理：%d%',round(step/nFrames*100)));
end
close(h)
end