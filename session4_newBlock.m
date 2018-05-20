function session4_newBlock(searchType, targetFeature, targetConjunction)
cla; %clear current axis if we start a new block

tx3 = text(0.15, 0.5, 'Targets:', 'FontSize', 32);
tx4 = text(0.5, 0.2, 'Press any key to continue', 'FontSize', 32);
tx4.HorizontalAlignment = 'center';
% define colours
brown = [153 102 51]/255;
green = [0 143 0]/255;
blue = [0 51 155]/255;

ty = text(0.5, 0.9, 'Hit "y" if you find any of the characters listed below, "n" otherwise','FontSize', 13);
ty.HorizontalAlignment = 'center';

if searchType == 1
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
    
    for i = 1:2
        
        tx = text([0.25 + i*.15], .5, target(i).chr, 'FontSize', 32, 'Color', target(i).color);
    end
end

if searchType == 2
     if targetConjunction == 1 % green T
        target(1).chr = 'T';
        target(1).color = green;
    else  % brown X
        target(1).chr = 'X';
        target(1).color = brown;
    end
    
    tx = text(0.4, .5, target(1).chr, 'FontSize', 32, 'Color', target(1).color);

    
end

set(gca, 'XTickLabel', '', 'YTickLabel', '', 'XTick', [], 'YTick', [], 'Box', 'off');
pause;



end
