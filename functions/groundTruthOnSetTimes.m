function [ groundTruth,label ] = groundTruthOnSetTimes( timesFile,Sr,sceneDuration)


if nargin==0, groundTruthOnSetTimes('~/Dropbox/dataExpcode/databases/bregmanClustering/dcase/OL/script01_bdm.txt',44100,120); return; end

%% init and load data
groundTruth=ones(1,Sr*sceneDuration);
[onset,offset,classNames] = loadEventsList(timesFile);

%% sorting onset in ascending order
[onset,id]=sort(onset);
offset=offset(id);
classNames=classNames(id);
label=unique(classNames);
label=['bg' label];

%% built dominant label in function of the onset time
for ii =1:length(onset)
    groundTruth(round(onset(ii)*Sr):round(offset(ii)*Sr))=find(not(cellfun('isempty', strfind(label,classNames{ii}))));
end


end

