function plot_map_scene(folderName, idx_global, ptsEst, ptsTruth, colors)
    disp(['Image ', num2str(idx_global), ' provides the global coordinate system.']);
    
    % Visualize the resulting 2D point cloud
    figure;
    set(gcf, 'Position', [100, 100, 1000, 2000]);

    % Estimated
    subplot(2, 1, 1);
    scatter(ptsEst(2, :), ptsEst(1, :), 10, colors, 'filled');
    axis equal;
    title('Estimated Reconstruction');

    % Truth
    subplot(2, 1, 2);
    scatter(ptsTruth(2, :), ptsTruth(1, :), 10, colors, 'filled');
    axis equal;
    title('Ground Truth Reconstruction');

    % Add a super title for the entire figure
    sgtitle(['Sparse Map of the Scene ', folderName]);
    saveas(gcf, fullfile('saved', [folderName, '_scene.png']));
end