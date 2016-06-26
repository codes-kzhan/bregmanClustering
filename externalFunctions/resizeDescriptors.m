function [newDesc varDesc] = resizeDescriptors(oldDesc,frameLength,nbFrames,winTime,hopTime,Fs)


dim = size(oldDesc,2);
winLength = round(winTime*Fs);
hopLength = round(hopTime*Fs);

newDesc = zeros(nbFrames,dim);
varDesc = zeros(nbFrames,dim);
startInd = 1;

for i = 1:nbFrames
    
    % Position of the current frame
    startPos = (i-1)*frameLength + 1;
    endPos =  startPos + frameLength - 1;
    
    % Get the index startInd of the first window in the current frame
    pos = 1 + hopLength*(startInd-1);
    if pos < startPos
        startInd = startInd + 1;
        pos = 1 + hopLength*(startInd-1);
    end
    
    % Get the index endInd of the last window in the current frame
    endInd = startInd;
    maxPos = endPos - winLength + 1;
    while pos < maxPos
        endInd = endInd + 1;
        pos = 1 + hopLength*(endInd-1);
    end
    
    % New descriptor for the current frame
    newDesc(i,:) = mean( oldDesc(startInd:endInd,:) , 1 );
    varDesc(i,:) = std( oldDesc(startInd:endInd,:) , 1 );
    startInd = endInd + 1;
    
end


end