function avgResidual = avg_residual(ptsEst, ptsTruth)
    % ptsEst and ptsTruth are 2xN matrices
    % avgResidual is the mean Euclidean distance

    if size(ptsEst, 2) ~= size(ptsTruth, 2)
        error('The number of points in ptsEst and ptsTruth must be the same.');
    end

    dif = ptsEst - ptsTruth;
    res = sqrt(sum(dif .^ 2, 1));
    avgResidual = mean(res);
    disp(['The average residual is ', num2str(avgResidual)]);
end
