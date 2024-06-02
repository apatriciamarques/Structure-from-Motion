function homography = normalized_DLT(pts2, pts1)
    % pts1 and pts 2 should be 4x2 matrices (4 points each)
    % Homography maps pixels in the second (pts1) into the first image (pts2)

    %% 1. Homogeneize and Normalize points
    pts1 = [pts1, ones(size(pts1, 1), 1)];
    pts2 = [pts2, ones(size(pts2, 1), 1)];
    [pts2, Tnorm2] = normalize_pts(pts2);
    [pts1, Tnorm1] = normalize_pts(pts1);

    %% 2. Apply DLT algorithm
    % Single 8x9 matrix A
    A = zeros(8, 9);
    for i = 1:4
        % Coordinates (row vectors)
        in = pts1(i, :);
        out = pts2(i, :);
        % Rows of matrix A for each correspondence
        A(2*i - 1, :) = [zeros(1,3), -out(3)*in, out(2)*in];
        A(2*i, :) = [out(3)*in, zeros(1,3), -out(1)*in];
    end
    % Obtain SVD of A
    [~, ~, V] = svd(A);
    % Solution for h is last column of V
    h = V(:, end);
    % Determine H from h
    homography = reshape(h, 3, 3)';

    %% 3. Denormalize solution
    homography = Tnorm2 \ (homography * Tnorm1);
end