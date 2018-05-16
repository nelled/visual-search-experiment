function [ design_matrix ] = generateDesignMatrix(subject_no)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
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

% Define values for columns
search_types = [1,2];
set_sizes = [1, 5, 15, 31];
target_present = [0, 1];

% Create combinations
[ca, cb, cc] = ndgrid(search_types, set_sizes, target_present);
combs = sortrows(repmat([ca(:), cb(:), cc(:)],10,1), 3);
combs

% Split on block
feature = combs(combs(:,1) ==1,:);
conjunction = combs(combs(:,1) ==2,:);

% Add target feature according to subject no. for the conjunction block we
% set those to 0
% Check if subject no even or uneven
if mod(subject_no, 2) == 0
    feature(:,size(feature,2)+1) = 2;
else
    feature(:,size(feature,2)+1) = 1;
end
conjunction(:,size(conjunction,2)+1) = 0;

% Add target feature for conjunction, for the feature block we set those to
% zero
feature(:,size(feature,2)+1) = 0;
conjunction(:,size(conjunction,2)+1) = repmat([1,2],1,size(conjunction,1)/2);


% Shuffle within block
feature = feature(randperm(size(feature,1)),:);
conjunction = conjunction(randperm(size(conjunction,1)),:);

% Add block
% TODO: simplify
b0(1:size(feature,1)) = 0;
b1(1:size(conjunction,1)) = 1;
feature = horzcat(b0', feature);
conjunction = horzcat(b1', conjunction);

% Assemble
design_matrix = vertcat(feature, conjunction);

% Add subject no
sno_vec(1:size(design_matrix,1)) = subject_no;
design_matrix = horzcat(sno_vec', design_matrix);

% Add trial counter
trials_vec = 1:size(design_matrix,1);
design_matrix = horzcat(design_matrix(:,1:2), trials_vec', design_matrix(:,3:end));
end
