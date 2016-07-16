function [newLabel,nbFrames] = resizeLabel(oldLabel,frameLength)

% [newLabel,nbFrames] = resizeLabel(oldLabel,frameLength)
% Gives one label per frame, choosing the most frequent value per frame
%
% INPUT
% oldLabel : vector containing the labels for each sample
% frameLength : length of a frame (in samples)
%
% OUTPUT
% newLabel : vector containing the labels for each frame
% nbFrames : number of frames (equals length(newLabel))

if ~isvector(oldLabel)
    error('The old label must be a vector');
end

L = length(oldLabel);
nbFrames = floor(L/frameLength);
newLabel = zeros(nbFrames,1);

if nbFrames == 0
    error('The frame length must be less or equal to the length of the signal');
end

for i = 1:nbFrames
    startPos = (i-1)*frameLength + 1;
    endPos = startPos + frameLength - 1;
    newLabel(i) = mode( oldLabel(startPos:endPos) );
end


end