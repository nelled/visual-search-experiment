% visual search experiment, inspired by Treisman & Gelade, 1980
% TODO: Keypress thing (stackoverflow)
% TODO: Bug for subject numbers > 10

% ==================================
% get subject number
% Exercise!
% Get a new subject number at every run 
% ==================================
% Sorry for this. I hate matlab. Isnt there som psychophysics for python?
current_dir = mfilename('fullpath');
idx=strfind(current_dir,'/');
folder=current_dir(1:idx(end));
folder = strcat(folder,'results/');
results = dir(folder);
isfile=~[results.isdir]; 
filenames= {results(isfile).name};
if isempty(filenames)
    subject_no = 1
else
    nums = cellfun(@(x) strsplit(x,'_'),filenames,'UniformOutput',false);
    nums = cat(1,nums{:});
    nums = nums(:,1);
    % TODO: BUG!!! Does only work until 10...
    nums = cell2mat(nums);
    nums = str2num(nums);
    subject_no = max(nums)+1; 

end

% ==================================
% Exercise!
% INITIALIZE the random number generator
% ==================================
% Do as in example.
rng(100*subject_no)

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
design = generate_design_matrix(subject_no);

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

welcome_screen(subject_no)

%design = [subject_no 1 1 2 5 1 1 1];

% ==============
% Exercise!
% = trial loop =
% Create a loop to present the sequence of trial
% ==============
results=zeros(size(design,1),2); %preallocate results matrix
lastblock=0;
for trial = 1:size(design,1)
trial = 1;

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
session4_newBlock(searchType, targetFeature, targetConjunction)
if block - lastblock > 0
   session4_newBlock(searchType, targetFeature, targetConjunction)
end
% ==============
% = run single trial =
% ==============  
%set(fig, 'KeyPressFcn', @Key_Down);
[rt, correct] = session4_presentTrial(fig, searchType, setSize, targetPresent, targetFeature, targetConjunction);
%set(fig, 'KeyPressFcn', '');


% ==============
% = save result =
% ==============
results(trial,:) = [rt correct];

lastblock = block;

end
close(fig);
% ==============
% Exercise!
% = write results to file =
% ==============
% (1) subject ID
% (2) Blockz
% (3) Trial
% (4) Search type: feature (1) or conjunction (2)
% (5) Set size: 1, 5, 15, 31
% (6) Target present: 0 == target absent, 1 == target present
% (7) Target feature (feature search): 1 == shape, 2 == color
% (8) Target conjunction (conjunction search): 1 == green T, 2 == brown X

cHeader = {'id' 'block' 'trial' 'search_type' 'set_size' 'target_present' 'target_feature' 'target_conjunction' 'reaction_time' 'correct'}; %headers
commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; %insert commas
commaHeader = commaHeader(:)';
textHeader = cell2mat(commaHeader); %cHeader in text with commas
% generate filename
fname = strcat(folder,int2str(subject_no),'_', datestr(now,'HH:MM:SS'), '.csv')
%write header to file
fid = fopen(fname,'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
results = horzcat(design,results)
%write data to end of file
dlmwrite(fname,results,'-append');
%y
