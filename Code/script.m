clc
clear all
DBFolder = dir('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\');
DBSize = length(DBFolder);
%Features = zeros(1, 308);->skrip asli
Features = zeros(1, 210);
k = 1;
lables = {};

for i = 3:DBSize
    SFolder = dir(strcat('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\', DBFolder(i).name, '\*.wav'));
    addpath(strcat('D:\Semester 5\FP Sinyal\Classification-of-Heart-Sound-Signal-Using-Multiple-Features-\sakaratul-maut\', DBFolder(i).name));
    SFSize = length(SFolder);

    for j = 1:SFSize
        filename = SFolder(j).name; % file name to be loaded
        [y, Fs] = audioread(filename, 'native'); % signal bieng loaded having data in variable y and frequency Fs
        c = getmswtfeat(double(y), Fs / 2, Fs / 8, Fs);
        [rr, cc] = size(c);

        for m = 1:7:rr - mod(rr, 7)
            %Features(k, :) = reshape(c(m:m + 6, :), [1 308]); ->skrip asli
            Features(k, :) = reshape(c(m:m + 6, :), 1, []);
            lables{k} = DBFolder(i).name;
            k = k + 1;

        end

    end

end

%converting to table
FeaturesX = array2table(Features);
lablesY = cell2table(lables');
%TrainingData = [FeaturesX lablesY]; ->skrip asli
TrainingData = [lablesY FeaturesX];

