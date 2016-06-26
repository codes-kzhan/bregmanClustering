function config = exposeClass(config, data, p)
% exposeClass EXPOSE of the expCode project bregmanClustering
%    config = exposeClass(config, data, p)
%       config : expCode configuration state
%       data : observations as a struct array
%       p : various display information

% Copyright: Gregoire Lafay
% Date: 30-Apr-2014





for k=1:length(data)
config = expDisplay(config, p);

subplot(311)
imagesc(data(k).classes{1});
subplot(312)
imagesc(data(k).classes{2});
subplot(313)
imagesc(data(k).classes{3});
title([p.rowNames{k, :}]);
end

% config = expDisplay(config, p);
% 
% k=2;
% figure(k);
% subplot(311)
% imagesc(data(k).classes{1});
% subplot(312)
% imagesc(data(k).classes{2});
% subplot(313)
% imagesc(data(k).classes{3});
% title([p.rowNames{k, :}]);
% 
% config = expDisplay(config, p);
% 
% k=3;
% figure(k);
% subplot(311)
% imagesc(data(k).classes{1});
% subplot(312)
% imagesc(data(k).classes{2});
% subplot(313)
% imagesc(data(k).classes{3});
% title([p.rowNames{k, :}]);
% end
% 
% 
% 
