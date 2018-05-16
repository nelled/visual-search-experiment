function [rt, correct] = session4_presentTrial(fig, searchType, setSize, targetPresent, targetFeature, targetConjunction)
% present a trial in visual search experiment
%
% input arguments
%	fig:	handle to figure used as drawing canvas
%	searchType:	feature(1) or conjunction(2)
%	setSize:	size of search set (4,8,12,16)
%	targetPresent:	does search display contain target? yes(1) or no(0)
%   targetFeature: defines the target feature for feature search condition; are we looking for a color singleton or a shape singleton?
%   targetConjunction: define the target stimulus for conjunction search (either green T or brown X)
%
% output arguments
%	rt: response time
%	correct: response correct
%
% Jochen Laubrock 2009


FS = 36; %font size
% initialize 'rt' and 'correct'
rt = NaN; %reaction time
correct = NaN; %answer correct?

% define colours
brown = [153 102 51]/255;
green = [0 143 0]/255;
blue = [0 51 155]/255;

cla; %clear figure
axis([-0.1 1.1 -0.1 1.1]) %set axis
set(gca, 'FontName', 'Consolas', 'XTickLabel', '', 'YTickLabel', '', 'XTick', [], 'YTick', [], ...
    'Box', 'off', 'XColor', [1 1 1], 'YColor', [1 1 1], 'FontSize', FS);




% draw random presentation positions
x = rand(setSize, 1);
y = rand(setSize, 1);


% all but the last item are distractors (with both distractor identities equally distributed)
% the last item is either a distractor or a target depending on 'targetPresent'
half = (setSize-1)/2;
distractorIdentity = [zeros(half, 1); ones(half, 1)] + 1;



% FEATURE SEARCH
if searchType == 1
    % define target- and distrcator identities
    distractor(1).chr = 'T';
    distractor(1).color = brown;
    distractor(2).chr = 'X';
    distractor(2).color = green;
    
    if targetFeature == 1 % shape singleton
        target(1).chr = 'S';
        target(1).color = brown;
        target(2).chr = 'S';
        target(2).color = green;
    else  % color singleton
        target(1).chr = 'T';
        target(1).color = blue;
        target(2).chr = 'X';
        target(2).color = blue;
    end
    
    % draw target
    if targetPresent
        
        if rand>5. %randomly present target identity 1
            g = text(x(setSize), y(setSize), target(1).chr, 'Color', target(1).color, 'FontSize', FS);
        else
            g = text(x(setSize), y(setSize), target(2).chr, 'Color', target(2).color, 'FontSize', FS);
        end
    
    else
        
        if rand>5. %randomly present distractor identity 1
            g = text(x(setSize), y(setSize), distractor(1).chr, 'Color',  distractor(1).color, 'FontSize', FS);
        else
            g = text(x(setSize), y(setSize), distractor(2).chr, 'Color',  distractor(2).color, 'FontSize', FS);
        end
    end
end



% CONJUNCTION SEARCH
if searchType == 2
    
    %Exercise!
    
end

% draw distractors
ng1 = text(x(distractorIdentity==1), y(distractorIdentity==1), distractor(1).chr, 'Color',  distractor(1).color, 'FontSize', FS);
ng2 = text(x(distractorIdentity==2), y(distractorIdentity==2), distractor(2).chr, 'Color',  distractor(2).color, 'FontSize', FS);


% measure response time
tic
pause;


%%%%
% Exercise!
% Find a way to accept only 'y' or 'n'
%%%%
%should work but doesnt.
% answ = get(fig, 'CurrentCharacter');
% while answ ~= 'n' & answ ~= 'y'
%     answ = get(fig, 'CurrentCharacter');
% end
answ = get(fig, 'CurrentCharacter');

rt = toc;


% evaluate the correctness of the answer
if (targetPresent==1 & lower(answ) == 'y') | (targetPresent==0 & lower(answ) == 'n')
    correct = 1;
elseif (targetPresent==0 & lower(answ) == 'y') | (targetPresent==1 & lower(answ) == 'n')
    correct = 0;
else
    correct = -99;
end


end