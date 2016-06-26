function [ sampleList ] = getSampleList(path)
    
fileID = fopen(path,'r');
formatSpec = '%s';
tmp = textscan(fileID,formatSpec);
fclose(fileID);

sampleList=tmp{1};

end

