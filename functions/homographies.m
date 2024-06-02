function hEst = homographies(folderData, threshold, print)
    % Track index J, index I, homography H and inliers number.
    % Homography maps pixels in the image I into the image J
    hEst = struct('j', [], 'i', [], 'homography', zeros(8, 9), 'inliersNumber', []);
    
    %% Step 0: Get H for all pairs
    c = 1;
    for i = 1:6
        for j = i+1:6
            if print
                disp(['Homography maps pixels in image ', num2str(i), ' into image ', num2str(j), ' and vice-versa...']);
            end
            [homography, inliersIndices] = pair_homography(folderData, i, j, threshold, false);
            % Store H info
            hEst(c).j = j;
            hEst(c).i = i;
            hEst(c).homography = homography;
            hEst(c).inliersNumber = numel(inliersIndices);
            c = c + 1;
            % Store inv(H) info
            hEst(c).j = i;
            hEst(c).i = j;
            hEst(c).homography = inv(homography);
            hEst(c).inliersNumber = numel(inliersIndices);
            % Increment
            c = c + 1;
        end
    end
    if print
        disp('Homographies estimation finished.');
    end
end