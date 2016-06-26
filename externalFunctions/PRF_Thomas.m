function [precision,recall,fMeasure] = PRF(confusionMtx)

% [precision,recall,fMeasure] = PRF(confusionMtx)
% Computes precision, recall and f-measure given a confusion matrix of
% sound detection where the first row and column is the background. Other
% rows and columns each correspond to one type of sound event.
% For a given type of event,
%    precision is (number of correct events)/(number of estimated events)
%    recall is (number of correct events)/(number of true events)
%    f-measure is 2*precision*recall/(precision+recall)
%
% INPUT
% confusionMtx : confusion matrix (rows: true label, columns: guessed
% label) first row must correspond to the background
%
% OUTPUT
% precision, recall, fMeasure : structures containing
%    .overall : value without telling appart the different types of event
%    .Vec : vector containing values for each type of event

[n,m] = size(confusionMtx);

if n ~= m
    error('Confusion matrix must be a square matrix');
end

precisionVec = zeros(n-1,1);
recallVec = zeros(n-1,1);
fMeasureVec = zeros(n-1,1);

for i = 1:n-1
    
    correctEvents = confusionMtx(i+1,i+1);
    estimatedEvents = sum(confusionMtx(:,i+1));
    groundTruth = sum(confusionMtx(i+1,:));

    if estimatedEvents ~= 0
        precisionVec(i) = correctEvents/estimatedEvents;
    end
    
    if groundTruth ~= 0
        recallVec(i) = correctEvents/groundTruth;
    end
    
    if correctEvents ~= 0
        fMeasureVec(i) = 2*precisionVec(i).*recallVec(i)./(precisionVec(i)+recallVec(i));
    end
    
end

guessedOverall = sum(sum(confusionMtx(2:end,2:end)));
estimatedOverall = sum(sum(confusionMtx(1:end,2:end)));
truthOverall = sum(sum(confusionMtx(2:end,1:end)));

precisionOverall = guessedOverall/estimatedOverall;
recallOverall = guessedOverall/truthOverall;
fMeasureOverall = 2*precisionOverall*recallOverall/(precisionOverall+recallOverall);

if isnan(precisionOverall)
    precisionOverall = 0;
end

if isnan(recallOverall)
    recallOverall = 0;
end

if isnan(fMeasureOverall)
    fMeasureOverall = 0;
end

precision = struct('overall',precisionOverall,'Vec',precisionVec);
recall = struct('overall',recallOverall,'Vec',recallVec);
fMeasure = struct('overall',fMeasureOverall,'Vec',fMeasureVec);

end