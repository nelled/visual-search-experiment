function [] = welcome_screen(subject_no)
cla; 


tx3 = text(0.5, 0.9, ['Welcome to the visual search experiment!'], 'FontSize', 12);
tx6 = text(0.5, 0.7, ['You will perform feature search and conjunction search'], 'FontSize', 10);
tx7 = text(0.5, 0.6, ['and your reaction time will be measured.'], 'FontSize', 10);
tx8 = text(0.5, 0.5, ['Press "y" if the target is present, "n" otherwise'], 'FontSize', 10);
tx4 = text(0.5, 0.3, ['Your subject number is ' num2str(subject_no)], 'FontSize', 12);
tx5 = text(0.5, 0.2, 'Press any key to continue', 'FontSize', 12);

tx3.HorizontalAlignment = 'center';
tx4.HorizontalAlignment = 'center';
tx5.HorizontalAlignment = 'center';
tx6.HorizontalAlignment = 'center';
tx7.HorizontalAlignment = 'center';
tx8.HorizontalAlignment = 'center';

set(gca, 'XTickLabel', '', 'YTickLabel', '', 'XTick', [], 'YTick', [], 'Box', 'off');
pause;


end

