function [config, store, obs] = brcl2clustering(config, setting, data)
% brcl2clustering CLUSTERING step of the expCode project bregmanClustering
%    [config, store, obs] = brcl2clustering(config, setting, data)
%       config : expCode configuration state
%       setting   : set of factors to be evaluated
%       data   : processing data stored during the previous step
%
%       store  : processing data to be saved for the other steps
%       obs    : observations to be saved for analysis

% Copyright: gregoirelafay
% Date: 25-Apr-2014

% Set behavior for debug mode.
if nargin==0,
    bregmanClustering('do', 2, 'mask',{[2], [6],0, [1], [2],0,2,3,0,0,[2], 1},'parallel',0);
    return;
end

%% Clustering step
% perform clustering using bregman divergences

% INPUT : setting
% setting.database : Name of the database to use
% setting.features : type of spectral features to compute (spectra,log spectra, logmel,loglogmel, 13 MFCC, 40 MFCC)
% setting.pooling : type of pooling to useon each chunk (average,max,maxfreq)
% setting.normalize : chunk normalization option : 1=normalize each chunk with the Standard deviation, 0=don't normalize the chunk.
% setting.frameTime : duration of the chunks (in seconde). If setting.frameTime = setting.wintime, we don't use chunk. ToRename : chunkTime


store=[];
obs=[];

disp('Version 2');
%% Fix the seed in order to be able to replicate the results
expRandomSeed();
%% Initialisation
%nmi=[];
accuracy = [];
obs.class.classes=[];
precision=[];
rappel=[];
fMesure=[];
precisionCW = [];
rappelCW = [];
fMesureCW = [];
precisionEvent = [];
rappelEvent = [];
fMesureEvent = [];
iterations= [];


%% RUN CLUSTERING
for jj=1:length(data.s)
    if config.store
        %% Spectra Normalization. Add an offset in order to get only positive features values, due to the log of KL and IS divergences
        %         data.s{jj}.feature = data.s{jj}.feature / max(data.s{jj}.feature(:));
        data.s{jj}.feature = data.s{jj}.feature - min(data.s{jj}.feature(:))+eps;
        switch setting.divergences
            case {'kl','is'}
                if(strcmp(setting.features,'spec') || strcmp(setting.features,'mfcc40') || strcmp(setting.features,'logmel'))
                    data.s{jj}.feature=data.s{jj}.feature./repmat(sum(data.s{jj}.feature,2),1,size(data.s{jj}.feature,2));
                end
        end
        
        %% Clustering Step : The replication loop is outside of the clustering functions
        %  nbClasses is the exact number of classes in the targeted scene
        nbClasses = length(unique(data.s{jj}.trueLabel(1,:)));
        
        % Init Criterion
        critMin=Inf;
        % Init iteration number for Kmeans
        opts = statset('MaxIter', setting.maxIter);
        
        % Replication loop
        for rr=1:setting.replicates;
            switch setting.method
                case 'bregman'
                    [classesTmp,centroidTmp,critTmp,iterationTmp]=bregmanClusteringAlgorithms(data.s{jj}.feature,nbClasses,1,setting.maxIter,setting.divergences,centroidInit);
                case 'kmeans'
                    %  Init centroids by randomly choosing nbClasses features
                    [centroidInit,~] = datasample(data.s{jj}.feature,nbClasses,'Replace',false);
                    warning off all
                    [classesTmp,centroidTmp,sumd]=kmeans(data.s{jj}.feature, nbClasses, 'replicates', 1,'start',centroidInit,'option',opts, 'EmptyAction', 'singleton');
                    critTmp=sum(sumd);
                    iterationTmp=setting.maxIter;
                    warning on all
                case 'random'
                    classes{jj} = ceil(rand(1, size(data.s{jj}.feature, 1))*nbClasses);
                case 'kproducts'
                    [classesTmp,centroidTmp,critTmp,iterationTmp]=kproducts(data.s{jj}.feature',nbClasses,1,setting.maxIter,centroidInit');
            end
            
            % Store the best replication according to the criterion
            if ~strcmp(setting.method,'random')
                if critMin>critTmp(end)
                    critMin = critTmp(end);
                    classes{jj}=classesTmp;
                    crit{jj}=critTmp;
                    centroid{jj}=centroidTmp;
                    iteration{jj}=iterationTmp;
                end
            end
        end
    else % if we need to reload the data
        classes{jj} = data.store.s{jj}.classes;
    end
    
    %% Store anbd sort classes ID
    clId = unique(classes{jj});
    ncl=[];
    for k=1:length(clId);
        ncl(classes{jj}==clId(k)) = k;
    end
    classes{jj} = ncl;
    %% Compute Metrics : OL dataset use two distinct annotations : size(data.s{jj}.trueLabel, 1) = 2. For the other databases size(data.s{jj}.trueLabel, 1) = 1
    for m=1:size(data.s{jj}.trueLabel, 1)
        %% Accuracy
        results = clusteringMetrics(data.s{jj}.trueLabel(m, :), classes{jj});
        accuracy = [accuracy results.accuracy];
        %nmi = [nmi results.nmi];
        
        %% Precision-Recall-FMeasure
        alignedClasses=[];
        
        for k=1:size(results.classMatching, 1)
            alignedClasses(classes{jj}==k) = find(results.classMatching(k, :)==1);
        end
        
        PRF = PRFmetrics(data.s{jj}.trueLabel(m,:),alignedClasses);
        precision = [precision PRF.precision];
        rappel = [rappel PRF.rappel];
        fMesure = [fMesure PRF.fMesure];
        precisionCW = [precisionCW PRF.precisionCW];
        rappelCW = [rappelCW PRF.rappelCW];
        fMesureCW = [fMesureCW PRF.fMesureCW];
        precisionEvent = [precisionEvent PRF.precisionEvent];
        rappelEvent = [rappelEvent PRF.rappelEvent];
        fMesureEvent = [fMesureEvent PRF.fMesureEvent];
        
        %% Store results for visualization
        obs.class.classes{jj} = [data.s{jj}.trueLabel; alignedClasses];
    end
    
    %% Store results for visualization
    if ~strcmp(setting.method,'random')
        iterations = [iterations iteration{jj}];
        store.s{jj}.centroid=centroid{jj};
        store.s{jj}.crit=crit{jj};
        store.s{jj}.iteration=iteration{jj};
    end
    
    store.s{jj}.classNames=data.s{jj}.classNames;
    store.s{jj}.trueLabel=data.s{jj}.trueLabel;
    store.s{jj}.classes=classes{jj};
end

%% Store results for visualization
%obs.nmi = nmi;
obs.accuracy = accuracy;
obs.precision= precision;
obs.recall= rappel;
obs.fMeasure=fMesure;
obs.precisionCW= precisionCW;
obs.recallCW= rappelCW;
obs.fMeasureCW=fMesureCW;
obs.precisionEvent= precisionEvent;
obs.recallEvent= rappelEvent;
obs.fMeasureEvent=fMesureEvent;
if ~strcmp(setting.method,'random')
    obs.interations=iterations;
end
end
%         for k=1:size(results{1}.classMatching, 1)
%             alignedClasses1(classes{1}==k) = find(results{1}.classMatching(k, :)==1);
%         end
%         for k=1:size(results{2}.classMatching, 1)
%             alignedClasses2(classes{2}==k) = find(results{2}.classMatching(k, :)==1);
%         end
%         for k=1:size(results{3}.classMatching, 1)
%             alignedClasses3(classes{3}==k) = find(results{3}.classMatching(k, :)==1);
%         end
%
%         obs.s1.confusionMatrix.prediction = alignedClasses1;
%         obs.s1.confusionMatrix.class = data.s{1}.trueLabel;
%         obs.s1.confusionMatrix.classNames = data.s{1}.classNames;
%
%         obs.s2.confusionMatrix.prediction = alignedClasses2;
%         obs.s2.confusionMatrix.class = data.s{2}.trueLabel;
%         obs.s2.confusionMatrix.classNames = data.s{2}.classNames;
%
%         obs.s3.confusionMatrix.prediction = alignedClasses3;
%         obs.s3.confusionMatrix.class = data.s{3}.trueLabel;
%         obs.s3.confusionMatrix.classNames = data.s{3}.classNames;


