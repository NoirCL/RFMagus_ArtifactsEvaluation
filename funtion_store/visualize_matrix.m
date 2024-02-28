function visualize_matrix(matrix)
    global MTS_ele_num
    matrix = rreshape(matrix, MTS_ele_num, MTS_ele_num);
    coloramp = [[185,243,237];[185,241,204];[242,242,185];[242,204,185]]./255;

    figure;
    hold on;
    for i = 1:size(matrix, 1)
        for j = 1:size(matrix, 2)
            value = matrix(i, j);
            
            if value == 0
                color = coloramp(1,:);
            elseif value == 1
                color = coloramp(2,:);
            elseif value == 2
                color = coloramp(3,:);
            else
                color = coloramp(4,:);
            end

            rectangle('Position', [j-1, size(matrix, 1)-i, 1, 1], 'FaceColor', color, 'EdgeColor', 'k'); % Draw gridlines.
            text(j-0.5, size(matrix, 1)-i+0.5, num2str(value), 'HorizontalAlignment', 'center', 'Color', 'k', 'FontSize', 10); % Display data values inside the cells, using black font color and a font size of 14.
        end
    end
    
    axis equal;
    axis off;
    hold off;
end
