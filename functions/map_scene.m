function [pts, ptsAll, colorsAll] = map_scene(H, folderData, folderName, plot)
    % each cell of pts will be of size 2xN
    % each cell of colors will be of size Nx3
    pts = cell(6, 1);
    ptsAll = [];
    colorsAll = [];

    % For each image
    for i = 1:numel(H)
        img = folderData(i).img;

        % Image points coordinates and colors
        pts1 = (folderData(i).validPts.Location)';
        colors = impixel(img, pts1(2, :), pts1(1, :));
        % Apply transformation
        pts{i} = perspective(H{i}, pts1);
        ptsAll = [ptsAll, pts{i}];
        colorsAll = [colorsAll; colors];
    end

    % Visualize the resulting 2D point cloud
    if plot
        % Plot
        figure;
        scatter(ptsAll(2, :), ptsAll(1, :), 10, colorsAll, 'filled');
        axis equal;
        sgtitle(['Sparse Map of the Scene ', folderName]);
    end
end