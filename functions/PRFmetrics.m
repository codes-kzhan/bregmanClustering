function [ PRF ] = PRFmetrics( trueLabel,alignedLabel)
% trueLabel : annotation
% alignedLabel : Results of the clustering task

% estimed : Number of detected events (1=background)
% detected : Number of correctly detected events
% detected : Number of events to detect (groundTruth)

estimed = length(find(alignedLabel  ~= 1)); 
groundTruth = length(find(trueLabel  ~= 1));

%% PRF
% Compute PRF metrics for all classes (not background)
trueLabelWithoutBg = trueLabel;
% set background index to 0
trueLabelWithoutBg(trueLabel==1)= 0; 
% correctly detected events
correct = length(find(((trueLabelWithoutBg)-(alignedLabel))==0));
% Compute Precision 
if(estimed==0)
    PRF.precision = 0;
else
    PRF.precision = correct/estimed;
end
% Compute Recall 
PRF.rappel =  correct/groundTruth;
% Compute F-measure 
if(PRF.precision+PRF.rappel==0)
    PRF.fMesure=0;
else
    PRF.fMesure = 2*PRF.precision* PRF.rappel/(PRF.precision+PRF.rappel);
end
%% PRFEvent
% compute PRF metrics considering all events as one class and Bg as an
% other class

% set  background  index to 0
trueLabelEvent = trueLabelWithoutBg; 
% set  Event  index to 1
trueLabelEvent(trueLabelWithoutBg ~=0) =1;

alignedLabelEvent=alignedLabel;
% set  background index of the groundTruth to 2
alignedLabelEvent(alignedLabel ==1) =2; % bg = 2;
% set  event index of the groundTruth to 1
alignedLabelEvent(alignedLabel ~=1)=1; 

% correctly detected events
correctEvent = length(find(((trueLabelEvent)-(alignedLabelEvent))==0));

% Compute Precision
if(estimed==0)
    PRF.precisionEvent=0;
else
    PRF.precisionEvent = correctEvent/estimed;
end
% Compute Recall
PRF.rappelEvent =  correctEvent/groundTruth;
% Compute F-measure
if(PRF.precisionEvent+PRF.rappelEvent==0)
    PRF.fMesureEvent =0;
else
    PRF.fMesureEvent = 2*PRF.precisionEvent* PRF.rappelEvent/(PRF.precisionEvent+PRF.rappelEvent);
end

%% PRFCW : Class-wise
% compute PRF metrics for each class, and average across the classes.

% init
precisionCW=[];
rappelCW=[];
fMesureCW=[];

% get ID of event classes
classesID = unique(trueLabel);
classesID=classesID(classesID ~=1); % without Bg

% Compute PRF metrics for each classes
for m = classesID
    estimedCW = length(find(alignedLabel == m));
    groundTruthCW = length(find(trueLabel  == m));
    trueLabelCW = trueLabel;
    trueLabelCW(trueLabel~=m)=0; % All non tested classes = 0;
    trueLabelCW(trueLabel==m)=1; % Tested class = 1;
    alignedLabelCW = alignedLabel;
    alignedLabelCW(alignedLabel ~= m)=2; % All non tested classes = 2;
    alignedLabelCW(alignedLabel == m)=1; % Tested class = 1;
    correctCW = length(find(((trueLabelCW)-(alignedLabelCW))==0));
    
    % Compute Precision
    if(estimedCW==0)
        precisionCWTmp=0;
    else
        precisionCWTmp = correctCW/estimedCW;
    end
    % Compute Recall
    rappelCWTmp = correctCW/groundTruthCW;
    % Average
    precisionCW = [precisionCW precisionCWTmp];
    rappelCW =  [rappelCW rappelCWTmp];
    fMesureCW = [fMesureCW 2*precisionCWTmp*rappelCWTmp/(precisionCWTmp+rappelCWTmp)];
end


PRF.precisionCW = mean(precisionCW);
PRF.rappelCW=mean(rappelCW);
% Replace NaN value due to (precisionCWTmp+rappelCWTmp) = 0 by 0
fMesureCW(~isfinite(fMesureCW))=0;
PRF.fMesureCW=mean(fMesureCW);
end

