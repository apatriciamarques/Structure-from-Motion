function plot_folder_images(folderData, folderName)   
    figure;
    set(gcf, 'Position', [100, 100, 800, 400]); 
    for j = 1:6
        img = folderData(j).img;
        size(img);
        subplot(2, 3, j);
        imshow(img);
        title(['Image ', num2str(j)]);
    end
    sgtitle(['Images from Folder ', folderName]);
    saveas(gcf, fullfile('saved', [folderName, '_images.png']));
end