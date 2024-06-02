function pts2Est = perspective(H, pts1)
    % pts1 should be a 2xN matrix
    % pts2Est will be a 2xN matrix

    % number of points
    N = size(pts1, 2);
    % Homogeneous coordinates (add a row of ones)
    pts1Hom = [pts1; ones(1, N)];
    % Apply the homography transformation
    pts2Hom = H * pts1Hom;
    % De-homogenize the points
    pts2Est = pts2Hom(1:2, :) ./ pts2Hom(3, :);
end