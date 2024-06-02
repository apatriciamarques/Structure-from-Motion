function [normPts, Tnorm] = normalize_pts(pts)
    % pts should be a Nx3 matrix (homogeneized)

    %% Translate points to have the centroid at the origin
    centroid = mean(pts, 1);
    ptsTranslated = pts - centroid;
    
    %% Isotropic scaling such that mean distance to origin is sqrt(2)
    scale = sqrt(2) / mean(vecnorm(ptsTranslated, 2, 2));
    
    %% Create normalization matrix
    Tnorm = [scale,  0,      -scale * centroid(1);
         0,      scale,  -scale * centroid(2);
         0,      0,      1];

    %% Homogeneize, apply T and de-homogeneize
    normPts = (Tnorm * pts')';
    % normPts will be a Nx3 matrix
end