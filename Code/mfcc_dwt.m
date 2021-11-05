clc
clear all
number_of_classes =5;
DBFolder=dir('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\');
DBSize=length(DBFolder);
Features=zeros(1,832);
k=1;
lables=zeros(1, number_of_classes);
lables={};
target=[];
for i=3:DBSize
    SFolder=dir(strcat('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\',DBFolder(i).name,'\*.wav'));
    addpath(strcat('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\',DBFolder(i).name));
    SFSize=length(SFolder);
    for j=1:SFSize
        filename = SFolder(j).name;                  % file name to be loaded
        [y, Fs] = audioread(filename, 'native');  % signal bieng loaded having data in variable y and frequency Fs
        cdwt = getmswtfeat(double(y),Fs/2,Fs/8,Fs);
% feat = getmswtfeat(x,winsize,wininc,SF)
        cmfc = melcepst(y, Fs*6 , 16, 16, (0.03 * Fs));%19, 24
        [rr,cc]=size(cdwt);
        rr
        mm=1;
        for m=1:8:rr-(mod(rr,8)+8)
            if (m < size(cmfc,1) && mm < rr)
%                 Features(k,1:352)=reshape(cdwt(m:m+7,:),[1 352]);
                Features(k,1:240)=reshape(cdwt(m:m+7,:), 1, []);
%                 Features(k,353:832)=reshape(cmfc(mm:mm+29,1:16),[1 480]);
                Features(k,240:719)=reshape(cmfc(mm:mm+29,1:16),[1 480]);
                lables{k}=DBFolder(i).name;
                mm=mm+30;
                Lables(k,i-2)=1;
                k=k+1;
            end
        end
        
    end
end
%converting to table
FeaturesX=array2table(Features);
lablesY=cell2table(lables');
TrainingData=[FeaturesX lablesY];

