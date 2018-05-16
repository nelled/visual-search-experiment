% visual search experiment, inspired by Treisman & Gelade, 1980


% ==================================
% get subject number
% Exercise!
% Get a new subject number at every run 
% ==================================
subjectNo = 1;


% ==================================
% Exercise!
% INITIALIZE the random number generator
% ==================================
% Do as in example.
rng(100*subjectNo)



% ==================================
% Exercise!
% generate design matrix and the target Feature (color or shape) and the
% target color () and the target symbol
% ==================================

% structure of design matrix
% Rows: 1:NTrials
% Columns:
% (1) subject ID
% (2) Block
% (3) Trial
% (4) Search type: feature (1) or conjunction (2)
% (5) Set size: 1, 5, 15, 31
% (6) Target present: 0 == target absent, 1 == target present
% (7) Target feature (feature search): 1 == shape, 2 == color
% (8) Target conjunction (conjunction search): 1 == green T, 2 == brown X
%todo: design matrix checker
%design matrix
% first generate first block, then second?

design = [subjectNo 1 1 1 5 1 1 1];


% ==================================
% open full screen figure window
% ==================================
siz = get(0, 'ScreenSize');
fig = figure('Position', siz);


% ==================================
% Exercise!
% WELCOME SCREEN
% Present a welcome message and wait for key press to continue with the
% experiment
% ==================================



% ==============
% Exercise!
% = trial loop =
% Create a loop to present the sequence of trials
% ==============
trial=1;
lastblock=0;
results=zeros(size(design,1),2); %preallocate results matrix
 


% ==============
% = read trial parameter from design-matrix=
% ==============

block = design(trial,2);
searchType = design(trial,4); 		% feature (1) or conjunction (2)
setSize =  design(trial,5); 		% set size
targetPresent = design(trial,6);	% 0: target absent, 1: target present
targetFeature = design(trial,7);    % 1 == shape, 2 == color
targetConjunction = design(trial,8); % 1 == green T, 2 == brown X


% ==============
% Exercise!
% = display information screen=
% Revise function session4_newBlock to present information on target
% identities for feature and conjunction search during blocks
% ==============
if block - lastblock > 0
   session4_newBlock(searchType, targetFeature, targetConjunction)
end
    
% ==============
% = run single trial =
% ==============  
[rt, correct] = session4_presentTrial(fig, searchType, setSize, targetPresent, targetFeature, targetConjunction);


% ==============
% = save result =
% ==============
results(trial,:) = [rt correct];


close(fig);

% ==============
% Exercise!
% = write results to file =
% ==============

