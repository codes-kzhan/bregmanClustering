function [config, store, obs] = brcl1analysis(config, setting, data)
% brcl1features FEATURES step of the expCode project bregmanClustering
%    [config, store, obs] = brcl1features(config, setting, data)
%       config : expCode configuration state
%       setting   : set of factors to be evaluated
%       data   : processing data stored during the previous step
%
%       store  : processing data to be saved for the other steps
%       obs    : observations to be saved for analysis

% Copyright: gregoirelafay
% Date: 25-Apr-2014

% Set behavior for debug mode.
if nargin==0, bregmanClustering('do', 1, 'mask',  {[1 2 4] 5 0 0 0 0 0 3 1 1 2 1},'parallel',1); return; end


%% Features Analysis
% use rastamat library to compute spectral features from the audio scenes

% INPUT : setting
% setting.database : Name of the database to use
% setting.features : type of spectral features to compute (spectra,log spectra, logmel,loglogmel, 13 MFCC, 40 MFCC)
% setting.pooling : type of pooling to useon each chunk (average,max,maxfreq)
% setting.normalize : chunk normalization option : 1=normalize each chunk with the Standard deviation, 0=don't normalize the chunk.
% setting.frameTime : duration of the chunks (in seconde). If setting.frameTime = setting.wintime, we don't use chunk. ToRename : chunkTime

store=[];
obs=[];

% disp('Version 2');
%% Load audio scene names
if(~isnan(setting.snr))
    sceneListPath=[config.inputPath,setting.dataBase,'/sampleList_EBR',num2str(setting.snr),'.txt'];
else
    sceneListPath=[config.inputPath,setting.dataBase,'/sampleList.txt'];
end

fileName = getSampleList(sceneListPath);

%% Analysis step : for each scene in the dataset, compute features.
for jj=1:length(fileName)
    [stereo,Fs] = wavread(strcat(config.inputPath,setting.dataBase,'/sound/',fileName{jj},'.wav'));
    scene=stereo(:,1);
    % Normalization across the scene
    scene = 0.99*scene./max(abs(scene));
    chunkLength = ceil(setting.frameTime * Fs);
    trueLabel=[];
    
    %% Load/adapt annotation in term of dominant events: one event per frame
    
    switch setting.dataBase
        % For the OL database, we need to adapt the annotation
        case {'events_OL_development','events_OL_test'}
            [dominantTrack,label] = groundTruthOnSetTimes( strcat(config.inputPath,setting.dataBase,'/annotation/',fileName{jj},'_sid.txt'),Fs,floor(length(scene)/Fs));
            [trueLabel(1, :),nbChunk] = resizeLabel(dominantTrack,chunkLength);
            [dominantTrack,label] = groundTruthOnSetTimes( strcat(config.inputPath,setting.dataBase,'/annotation/',fileName{jj},'_bdm.txt'),Fs,floor(length(scene)/Fs));
            [bdm,nbChunk] = resizeLabel(dominantTrack,chunkLength);
            trueLabel(2, :) = bdm(1:min(length(bdm), size(trueLabel, 2)));
        % load annotation
        case {'events_OS_development_instance','events_OS_test_instance','events_OS_development_instance_replicates','events_OS_test_instance_EBR0','events_OS_test_instance_EBR6','events_OS_development_instance_EBR0','events_OS_development_instance_EBR6','events_OS_test_instance_replicates_EBR0'}
            load(strcat(config.inputPath,setting.dataBase,'/annotation/',fileName{jj},'.mat')); % load sceneDuration, sceneObjects, sceneSchedule
            load(strcat(config.inputPath,setting.dataBase,'/annotation/',fileName{jj},'-dominant.mat')); % load dominantObject, dominantTrack
            [trueLabel(1,:),nbChunk] = resizeLabel(dominantTrack,chunkLength);
            label = {sceneObjects.label};
            label=label(unique([sceneSchedule.sampleId]));
    end
    
    Xfinal = [];
    
    %% Compute Features
    for mm=1:nbChunk
        
        % Position of the current chunk
        startPos = (mm-1)*chunkLength + 1;
        endPos =  startPos + chunkLength - 1;
        chunk=scene(startPos:min(length(scene), endPos));
        
        % % Normalization across each chunk
        if setting.normalize
            chunk=chunk./std(abs(chunk));
        end
        
        % Rastamat function
        if strcmp(setting.features, 'mfcc40')
            [cepstra,aspectrum,pspectrum] = melfcc(chunk,Fs,'wintime',setting.winTime,'hoptime',setting.hopTime, 'numcep', 40);
        else
            [cepstra,aspectrum,pspectrum] = melfcc(chunk,Fs,'wintime',setting.winTime,'hoptime',setting.hopTime);
        end
        
        % Store computed features and applied log if needed
        switch setting.features
            case 'spec'
                X = pspectrum;
            case 'logspec'
                X = log(pspectrum);
            case 'logmel'
                X = aspectrum;
            case 'loglogmel'
                X = log(aspectrum);
            case {'mfcc', 'mfcc40'}
                X = cepstra(2:end,:); % doesn't take the first MFCC
        end
        
        % Pooling step
        switch setting.pooling
            case 'average' % Average spectral features
                X=mean(X, 2);
            case 'max' % Pooling spectral features having the most energy
                [~,I]=max(sum(X,1));
                X=X(:,I);
            case 'maxFreq' % Pooling each frequency-bin having the most energy
                X=max(X,[],2);
        end
        Xfinal(mm,:)=X;
    end
    
    
    store.s{jj}.feature=Xfinal;
    store.s{jj}.trueLabel = trueLabel;
    store.s{jj}.nbChunk = nbChunk;
    store.s{jj}.classNames = label;
    
    
end

end





