function [homography, inliersIndices] = ransac_homography(pts1, pts2, threshold, print)
    N = size(pts1, 1); % data points
    n = 4; % n random data points (correspondences)
    % Initialize
    k = 0; % k iterations
    bestNrInliers = 0; % initial number of inliers of the model
    p = 0; % probability of picking an inlier randomly
    mu = 0.05; % probability of not picking all-inlier sample in k iterations
    if print
        disp(['Probability of not picking all-inlier sample in k iterations (mu) = ' num2str(mu)]);
    end
    %% While probability of missing correct model > η
    while (1-p^n)^k > mu % number of iterations as a function of confidence
        % 1. Estimate model from n random data points
        subset_indices = randperm(N, n);
        pts1Subset = pts1(subset_indices, :);
        pts2Subset = pts2(subset_indices, :);
        % 2. Estimate a homography. Fit model parameters to this subset.
        homographyModel = normalized_DLT(pts2Subset, pts1Subset);
        % 3. Estimate support of model using the residuals of all the measurements.
        errors = estimate_errors(homographyModel, pts1', pts2');
        inliersIndicesModel = find(errors < threshold);
        nrInliersModel = numel(inliersIndicesModel);
        %% 4. If more inliers than previous best model
        if nrInliersModel > bestNrInliers
            %% Update best model
            bestNrInliers = nrInliersModel; % update number of inliers
            p = bestNrInliers/N; % inlier ratio estimate
            homography = homographyModel; % store best homography
            inliersIndices = inliersIndicesModel; % store inliers indices for this model
            %if print
            %    disp(['iteration ' num2str(k) ': inliers probability = ' num2str(p) ...
            %    ', probability of missing correct model (1-p^n)^k = ' num2str((1-p^n)^k)]);
            %end
        end
        k = k + 1;
    end
    disp(['Final RANSAC iteration = ' num2str(k) ', inliers probability = ' num2str(p)]);
end
