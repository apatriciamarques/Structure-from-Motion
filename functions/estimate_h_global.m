function [HglobalEst, idx_global] = estimate_h_global(hEst, print)
    % Track which images have been processed
    processed = false(1, 6); 

    %% Step 1: Select the image pair with the largest number of inliers as the starting pair
    % Remember: H maps pixels in the second (i) into the first image (j)
    [~, bestIndex] = max([hEst.inliersNumber]);   
    best_j = hEst(bestIndex).j;
    best_i = hEst(bestIndex).i;
    % The first image (j) provides a global coordinate system
    idx_global = best_j;
    processed(best_j) = true;
    HglobalEst{best_j} = eye(3);
    if print
        disp(['Image ', num2str(best_j), ' provides the global coordinate system.']);
    end
    % The homography H provides the mapping from the second image (i) into the global coordinate system (j).
    processed(best_i) = true;
    HglobalEst{best_i} = hEst(bestIndex).homography;
    if print
        disp(['Homography for image ', num2str(best_i), ' completed.']);
    end
    
    %% Step 2: Iteratively add the other images
    while any(~processed)
        maxInliers = 0;
        top_i = -1; 
        top_j = -1;
        % Among all images not yet included
        for i = find(~processed)   
            % Let J be the corresponding image in the reconstruction
            for j = find(processed)
                % Retrieve the homography from the structure
                c = find(([hEst.i] == i) & ([hEst.j] == j));
                if any(c)
                    inliersNumber = hEst(c).inliersNumber;
                else
                    disp(['Homography not found for i=', num2str(i),' and j=',num2str(j)]);
                    break;
                end
                % Select the image I that has the largest number of homography inliers with any of the images already included
                if inliersNumber > maxInliers
                    maxInliers = inliersNumber;
                    top_i = i;
                    top_j = j;
                end
            end
        end
        if top_i == -1 || top_j == -1
            disp('No valid homography found, terminating early.');
            break;
        end
        % Use H_J,I and the known mapping H_J from the coordinate system of J into the global coordinate system to compute the global homography H_I for image I
        % (From J to Global Coordinate System) * (From I to J)
        processed(top_i) = true;
        HglobalEst{top_i} = HglobalEst{top_j} * hEst([hEst.i] == top_i & [hEst.j] == top_j).homography;
        if print
            disp(['Homography for image ', num2str(top_i), ' completed. Best match with processed image ', num2str(top_j)]);
        end
    end
    if print
        disp('Global Homographies Estimation Finished.');
    end
end