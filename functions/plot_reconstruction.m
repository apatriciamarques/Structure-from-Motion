function plot_reconstruction(folderName, idx_global, ptsEst, ptsTruth, cmap)
    disp(['Image ', num2str(idx_global), ' provides the global coordinate system.']);

    % Visualize the resulting 2D point cloud
    figure;
    set(gcf, 'Position', [100, 100, 1000, 2000]);
    cmap = lines(6);

    % Estimated
    subplot(2, 1, 1);
    hold on;
    for i = 1:numel(ptsEst)
        scatter(ptsEst{i}(1, :), ptsEst{i}(2, :), 1, cmap(i, :), 'filled');
    end
    hold off;
    axis equal;
    title('Estimated Reconstruction');

    % Truth
    subplot(2, 1, 2);
    hold on;
    for i = 1:numel(ptsTruth)
        scatter(ptsTruth{i}(1, :), ptsTruth{i}(2, :), 1, cmap(i, :), 'filled');
    end
    hold off;
    axis equal;
    title('Ground Truth Reconstruction');

    % Add a super title for the entire figure
    sgtitle(['Sparse Map of the Scene ', folderName]);
    saveas(gcf, fullfile('saved', [folderName, '_reconstruction.png']));
end