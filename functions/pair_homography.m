function [homography, inliersIndices] = pair_homography(folderData, index1, index2, threshold, print) 
    % Match SIFT features between pairs of images
    [matchedPts1, matchedPts2] = pair_matches(folderData, index1, index2); 
    % Store each estimated homography, together with the inlier matches to it.
    [homography, inliersIndices] = ransac_homography(matchedPts1, matchedPts2, threshold, print);
end