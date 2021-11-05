clc
clear all
DBFolder=dir('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\');
DBSize=length(DBFolder);
Features=zeros(1,480);
k=1;
lables={};
for i=3:DBSize
    SFolder=dir(strcat('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\',DBFolder(i).name,'\*.wav'));
    addpath(strcat('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\',DBFolder(i).name));
    SFSize=length(SFolder);
    for j=1:SFSize
        filename = SFolder(j).name;                  % file name to be loaded
        [y, Fs] = audioread(filename, 'native');  % signal bieng loaded having data in variable y and frequency Fs
        c = melcepst(y, 8000 , 16, 24, (0.03 * Fs));%19, 24
        [rr,cc]=size(c);
        for m=1:30:rr-mod(rr,30)
            Features(k,:)=reshape(c(m:m+29,1:16),[1 480]);
            lables{k}=DBFolder(i).name;
            k=k+1;
            
        end
    end
end
%converting to table
FeaturesX=array2table(Features);
lablesY=cell2table(lables');
TrainingData=[FeaturesX lablesY];


