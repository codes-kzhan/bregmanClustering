function [ classes,centroids,sumDistsTmp, iteration ] = bregmanClusteringAlgorithms(feature,nbClasses,replicates,maxIter,divergences,Init)
%% Perform clustering using different bregman divergences
%% Input
% feature : (frame,dimension) matrix containing the features used to perform clustering. 
% nbClasses : number of centoids
% replicates : number of replication (1 if the replication loop is outside of the function)
% maxIter : maximum number of iteration
% divergences : type of divergence to use (euclidean,kullback-leibler,Itakura-Saito)
% Init : (nbClasses,dimension) matrix containing the initial centroids positions

%% Output
% classes : (frame,1) vector containing the index of the classes found in each frame
% centroids : (nbClasses,dimension) matrix containing the final centroids positions
% sumDistsTmp : (iteration,1) vector containing the criterion values at each iteration step
% iteration : number of iteration used to converge

[nbSamples,dim] = size(feature);
if nbClasses > nbSamples
    error('Number of clusters must be less than number of samples');
end

for nn = 1:replicates
    centroidsTmp=Init;
    classesTmp = zeros(nbSamples,1);
    minDists = zeros(nbSamples,1);
    sumDists = Inf;
    iteration = 1;
    centroidsLast = centroidsTmp;

    while iteration<maxIter 
        
        %% Assignement step : each sample is assigned to the nearest centroid
        % using vectorial format (time savings by a factor of 20 using four cores of 3.6ghz in parallel)
        if 1
            switch divergences
                case 'eu'
                    d =  - 2 * centroidsTmp * feature' + repmat(sum(centroidsTmp.^2, 2), 1, nbSamples);
                case 'kl'
                    d = -log(centroidsTmp)*feature'; 
                case 'is'
                    d = (feature*(centroidsTmp.^-1)' + repmat(sum(log(centroidsTmp), 2), 1, nbSamples)')'; 
                    
            end
            [minDists, classesTmp] = min(d, [], 1);
        % using loop    
        else
            for i = 1:nbSamples
                
                dmin = Inf;
                for j = 1:nbClasses
                    centroid = centroidsTmp(j,:);
                    switch divergences
                        case 'eu'
                            d(i, j) = sum( (feature(i,:)-centroid).^2 );
                        case 'kl'
                            d(i, j) = sum( feature(i,:).*log(feature(i,:)./centroid) );
                        case 'is'
                            d(i, j) = sum ( feature(i,:)./centroid - log(feature(i,:)./centroid) - 1 );
                        otherwise
                            error(strcat('Divergence must be either ''eu'', ''is'' or ''kl'' ; got "',divergences,'"'));
                    end
                    
                    if d(i, j) < dmin
                        dmin = d(i, j);
                        nearest = j;
                    end
                end
                
                classesTmp(i) = nearest;
                minDists(i) = dmin;
            end
        end
        sumDistsTmp(iteration) = sum(minDists);
        
        
        %% Compute new centroids
        for j = 1:nbClasses
            idx = find(classesTmp==j);
            if idx
                centroidsTmp(j,:) = mean(feature(idx,:));
            end
        end
        %% Break if centroids don't change 
        if sum(centroidsTmp(:)-centroidsLast(:)) == 0
            break;
        else
            centroidsLast = centroidsTmp;
        end
        iteration = iteration + 1;
        
    end
    
    %% Choose the best replication
    if sumDistsTmp(end)< sumDists
        sumDists = sumDistsTmp(end);
        classes = classesTmp;
        centroids = centroidsTmp;
    end
end


