function [matchedPts1, matchedPts2] = pair_matches(folderData, index1, index2) 
    % Get descriptors and valid points for the two images
    descs1 = folderData(index1).descs;
    validPts1 = folderData(index1).validPts;
    descs2 = folderData(index2).descs;
    validPts2 = folderData(index2).validPts;
    % Match SIFT features between pairs of images
    corrs = matchFeatures(descs1, descs2, 'MaxRatio', 0.8, 'MatchThreshold', 100);
    matchedPts1 = validPts1(corrs(:, 1)).Location;
    matchedPts2 = validPts2(corrs(:, 2)).Location;
end