function plot_matches(folderData, index1, index2)
    img1 = folderData(index1).img;
    img2 = folderData(index2).img;

    % Get matching points
    [matchedPts1, matchedPts2] = pair_matches(folderData, index1, index2);

    figure;
    set(gcf, 'Position', [100, 100, 1000, 500]);
    % Plot the img1
    subplot(1, 2, 1);
    imshow(img1);
    hold on;
    plot(matchedPts1(:, 1), matchedPts1(:, 2), 'ro');
    title(['Image ', num2str(index1)]);
    hold off;
    % Plot img2
    subplot(1, 2, 2);
    imshow(img2);
    hold on;
    plot(matchedPts2(:, 1), matchedPts2(:, 2), 'ro');
    title(['Image ', num2str(index2)]);
    hold off;
    % Title
    sgtitle('Matching Features');
end