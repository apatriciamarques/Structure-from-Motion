function analysis(data, folders)
    % Suppose prepare_images.m has been run already.
    % folders = {'bark', 'wall', 'graf', 'boat'};
    threshold = [3, 50, 50, 3];
    for i = 1:4
        % Folder info
        th = threshold(i);
        folderName = folders{i};
        disp(['--- Analysis for folder ', folderName, '...']);
        folderData = data.(folderName).folderData;
        plot_folder_images(folderData, folderName);
        % Estimation
        hEst = homographies(folderData, th, true);
        [HglobalEst, idx_global] = estimate_h_global(hEst, false);
        [ptsEst, ptsEstAll, colorsAll] = map_scene(HglobalEst, folderData, folderName, false);
        % Ground truth
        H1_to = data.(folderName).H1_to;
        HglobalTruth = to_global(H1_to, idx_global);
        [ptsTruth, ptsTruthAll, ~] = map_scene(HglobalTruth, folderData, folderName, false);
        % Comparison
        disp(['Inlier threshold = ' num2str(th)]);
        avg_residual(ptsEstAll, ptsTruthAll);
        plot_map_scene(folderName, idx_global, ptsEstAll, ptsTruthAll, colorsAll);
        plot_reconstruction(folderName, idx_global, ptsEst, ptsTruth);
    end
end