function errors = estimate_errors(H, pts1, pts2)
    % pts1 and pts 2 should be 2xN matrices
    % errors will be an N-vector

    % estimated points
    pts2Est = perspective(H, pts1);
    % calculate errors
    errors = vecnorm(pts2Est - pts2, 2, 1)';
end