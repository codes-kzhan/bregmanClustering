function config = brclReport(config)
% brclReport REPORTING of the expCode project bregmanClustering
%    config = brclInitReport(config)
%       config : expCode configuration state

% Copyright: gregoirelafay
% Date: 25-Apr-2014


%% Presentation IRCAM mathieu
if nargin==0, bregmanClustering('report', 1, 'reportName', 'comparaison'); return; end  % idierSlides lagrange2Slides

switch config.reportName
    case 'comparaison'
        mask = {[5], [1 3 6],0, [1], [0],0,2,1,0,0,[2], 1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[8], [1 3 6],0, [1], [0],0,2,1,0,0,[2], 1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);        
        mask = {[5], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[8], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
    case 'EBR0_replicate'
        mask = {[4], [1 3 6],0, [1], [0],0,2,1,0,0,[2], 1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[7], [1 3 6],0, [1], [0],0,2,1,0,0,[2], 1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask ={[11],[1 3 6],0,[1],0,1,2,1,1,1,2,1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        
        mask = {[4], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[7], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[11], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);      
        
    case 'EBR0_test'
        
        mask = {[5], [1 3 6],0, [1], [0],0,2,1,0,0,[2], 1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[6], [1 3 6],0, [1], [0],0,2,1,0,0,[2], 1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[8], [1 3 6],0, [1], [0],0,2,1,0,0,[2], 1};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        
        mask = {[5], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[6], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        mask = {[8], [1 3 6],0, [1], [0],0,2,3,0,0,[2], 0};
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);

        
    case 'testAnalysis'
         for db=  [4 7 8] % [1 9 10] %
        mask = {[db], [1 3 6], 0, 1, [1 3], 1, 2, 3, 1, 1, 2, 0};
                 config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'obs', [2 3], 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3], 'total', 1, 'percent', [2 3]);
         end

    case ''
        mask = {[3], [1], [1 2 3 4 7], [1], [0],0,2,1,0,0,[2], 1};
        %         config = expExpose(config, 't', 'mask',mask,'obs',[2 3], 'obs', 1);
        config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'obs', 1, 'order', [ 1 2 12 4 5 6 7 8 9 10 11 3]);
        %         config = expExpose(config, 'l', 'mask',mask,'obs',[2 3], 'obs', 1, 'expand', 'snr');
        %  config = expExpose(config, 'p', 'mask',mask,'obs',[2 3], 'obs', 1, 'expand', 'snr');
        
    case 'lagrange2Slides'
        %frame based
        %ol
        config = expExpose(config, 'l', 'mask', {[1], [1 3 6], [0], [1], [1 2 3],0,2,1,0,0,[2], 1},'obs',[2 3], 'total', 1);
        return
        
        %os
        config = expExpose(config, 'l', 'mask', {[2], [1 3 6], [0], [1], [1 2 3],0,2,1,0,0,[2], 1},'obs',[2 3], 'total', 1);
        
        %osr
        % config = expExpose(config, 'p', 'mask', {[3], [1 3 5], [1 2 3 4 7], [1],
        % [1 3],0,2,1,0,0,[2], 1},'obs',[2], 'expand', 'snr'); % FIXME
        
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [1], [1], [1 3],0,2,1,0,0,[2], 1},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [ 2], [1], [1 3],0,2,1,0,0,[2], 1},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [3 ], [1], [1 3],0,2,1,0,0,[2], 1},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [ 4 ], [1], [1 3],0,2,1,0,0,[2], 1},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [7], [1], [1 3],0,2,1,0,0,[2], 1},'obs',[2 3], 'sort', -2);
        
        %pooling
        %ol
        config = expExpose(config, 'l', 'mask', {[1], [1 3 6], [0], [1], [1 3],0,2,3,0,0,[2], [1 2]},'obs',[2 3]);
        %os
        config = expExpose(config, 'l', 'mask', {[2], [1 3 6], [0], [1], [1 3],0,2,3,0,0,[2], [1 2]},'obs',[2 3]);
        % osr
        
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [1], [1], [1 3],0,2,2,0,0,[2], [1 2]},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [ 2], [1], [1 3],0,2,2,0,0,[2], [1 2]},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [3 ], [1], [1 3],0,2,2,0,0,[2], [1 2]},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [ 4 ], [1], [1 3],0,2,2,0,0,[2], [1 2]},'obs',[2 3], 'sort', -2);
        config = expExpose(config, 'l', 'mask', {[3], [1 3 6], [7], [1], [1 3],0,2,2,0,0,[2], [1 2]},'obs',[2 3], 'sort', -2);
        
        norm=1;
        
        % frame based, not normalized
        %ol
        config = expExpose(config, 'l', 'mask', {[1], [1 3 6], [0], [1], [1 2 3],0,2,1,0,0,norm, 1},'obs',[2 3]);
        
        %os
        config = expExpose(config, 'l', 'mask', {[2], [1 3 6], [0], [1], [1 2 3],0,2,1,0,0,norm, 1},'obs',[2 3]);
        
        % pooling, not normalized
        
        %ol
        config = expExpose(config, 'l', 'mask', {[1], [1 3 6], [0], [1], [1 3],0,2,3,0,0,norm, [1 2]},'obs',[2 3]);
        %os
        config = expExpose(config, 'l', 'mask', {[2], [1 3 6], [0], [1], [1 3],0,2,3,0,0,norm, [1 2]},'obs',[2 3]);
        % osr
    case 'idierSlides'
        
        
        %% Kproducts
        % Only kproducts
        %ol
        config = expExpose(config, 'l', 'mask', {[1], [1 2 3 4 5 6], [0], [4], [1 3],0,2,1,0,0,[2], 1},'obs',[2 3]);
        %os
        config = expExpose(config, 'l', 'mask', {[2], [1 2 3 4 5 6], [0], [4], [1 3],0,2,1,0,0,[2], 1},'obs',[2 3]);
        %ol
        config = expExpose(config, 'l', 'mask', {[1], [2 4 5 6], [0], [4], [1 3],0,2,3,0,0,[2], 0},'obs',[2 3]);
        %os
        config = expExpose(config, 'l', 'mask', {[2], [2 4 5 6], [0], [4], [1 3],0,2,3,0,0,[2], 0},'obs',[2 3]);
        % Comparaison
        %pooling
        %ol
        config = expExpose(config, 'l', 'mask', {[1], [2 4], [0], [1 4], [1 3],0,2,3,0,0,[2], 1},'obs',[2 3]);
        config = expExpose(config, 'l', 'mask', {[1], [2 4], [0], [1 4], [1 3],0,2,3,0,0,[2], 2},'obs',[2 3]);
        config = expExpose(config, 'l', 'mask', {[1], [2 4], [0], [1 4], [1 3],0,2,3,0,0,[2], 3},'obs',[2 3]);
        %os
        config = expExpose(config, 'l', 'mask', {[2], [2 4], [0], [1 4], [1 3],0,2,3,0,0,[2], 1},'obs',[2 3]);
        config = expExpose(config, 'l', 'mask', {[2], [2 4], [0], [1 4], [1 3],0,2,3,0,0,[2], 2},'obs',[2 3]);
        config = expExpose(config, 'l', 'mask', {[2], [2 4], [0], [1 4], [1 3],0,2,3,0,0,[2], 3},'obs',[2 3]);
        %ALL
        %os
        config = expExpose(config, 'l', 'mask', {[2], [1 2 4 6], [0], [1 4], [1 3],0,2,3,0,0,[2], 1},'obs',[2 3]);
        config = expExpose(config, 'l', 'mask', {[2], [1 2 4 6], [0], [1 4], [1 3],0,2,3,0,0,[2], 2},'obs',[2 3]);
        config = expExpose(config, 'l', 'mask', {[2], [1 2 4 6], [0], [1 4], [1 3],0,2,3,0,0,[2], 3},'obs',[2 3]);
        %OSR
        % config = expExpose(config, 'l', 'mask', {[3], [1 2 4 6], [4], [1 4], [1 3],0,2,3,0,0,[2], 2},'obs',[2 3]);
        % config = expExpose(config, 'l', 'mask', {[3], [1 2 4 6], [4], [1 4], [1 3],0,2,3,0,0,[2], 3},'obs',[2 3]);
        %VISU
        
        
        config = expExpose(config, 'class', 'mask', { {1,1,0,[1],[3],0,2,3,0,0,2,1}, {1,6,0,[1],[1],0,2,3,0,0,2,1}, {1,4,0,[4],[1 3],0,2,3,0,0,2,2}},'obs',[2 3]);
        
        
    otherwise
        disp('Unkown report Name.');
end


%% MLSP 2014

% norm=2;
%
% config = expExpose(config, 'l', 'mask', {[1 2], [1], 0, [1], [1],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [3], 0, [1], [1],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [4], 0, [1], [1],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [5], 0, [1], [1],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [6], 0, [1], [1],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [1], 0, [1], [3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [3], 0, [1], [3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [4], 0, [1], [3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [5], 0, [1], [3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [6], 0, [1], [3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [1], 0, [1], [2],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [3], 0, [1], [2],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [4], 0, [1], [2],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [5], 0, [1], [2],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1 2], [6], 0, [1], [2],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
%
%
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [1], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort',-1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [2], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort',-1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [3], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort',-1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [6], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort',-1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [7], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort',-1);
%
% config = expExpose(config, 'l', 'mask', {[1 2], [1   3  5 6], 0, [1], [1 2 3],0,2,1,0,0,[norm]}, 'expand', 1,'metric',[2], 'percent', 0);
%
% config = expExpose(config, 'l', 'mask', {3, [3  6], [1], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort',1);
%
% config = expExpose(config, 'l', 'mask', {[1 2], [1   3  5 6], 0, [1], [2],0,2,1,0,0,[norm ]},'metric',[3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[1], [1], 0, [3], [2],0,2,1,0,0,[norm ]},'metric',[2 3], 'percent', 0, 'sort', -1);
% config = expExpose(config, 'l', 'mask', {[2], [1], 0, [3], [2],0,2,1,0,0,[norm ]},'metric',[2 3], 'percent', 0, 'sort', -1);
%
%
% db=1;
% config = expExpose(config, 'l', 'mask', {db, [1   3  5 6], 0, [1], [1 2 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort', 1);
% % config = expExpose(config, 'l', 'mask', {db, [1], 0, [3], [1],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort', 1);
% db=2;
% % config = expExpose(config, 'l', 'mask', {db, [1  3 5], 0, [1], [1  3],0,2,1,0,0,[1]},'metric',[2 3 4], 'percent', 0, 'sort', 1);
% config = expExpose(config, 'l', 'mask', {db, [1  3  5 6], 0, [1], [1 2 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort', 1);
% % config = expExpose(config, 'l', 'mask', {db, [1], 0, [3], [1],0,2,1,0,0,[norm ]},'metric',[2 3 4], 'percent', 0, 'sort', 1);
%
% config = expExpose(config, 'l', 'mask', {[1 2], [1   3  5 6], 0, [1], [2],0,2,1,0,0,[norm ]},'metric',[4], 'percent', 0, 'sort', -1);
%
% % config = expExpose(config, 'l', 'mask', {[1 2], [1 3 5], 0, [1], [1  3],0,2,1,0,0,[1]},'metric',[2 3 4], 'percent', 0, 'sort', -2);
% % config = expExpose(config, 'l', 'mask', {[1 2], [1 3 4 5 6], 0, [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort', -1);
%
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [1], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort',1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [2], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort',1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [3], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort',1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [6], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort',1);
% config = expExpose(config, 'l', 'mask', {3, [1 3  6], [7], [1], [1 3],0,2,1,0,0,[norm]},'metric',[2 3 4], 'percent', 0, 'sort',1);
% config = expExpose(config, 'l', 'mask', {3, [5], [6], [3], [1 3],0,2,1,0,0,[norm]},'metric',[2 3], 'percent', 0, 'sort',1);



%% Exemple
%config = expExpose(config, 'l');
%config = expExpose(config, 'l', 'step', 1, 'metric', 1, 'variance', 0, 'mask', {1}, 'save', 'toto');
%config = expExpose(config, 'p', 'expand', 'snr', 'metric', 'accuracy', 'percent', 1, 'save', 1);