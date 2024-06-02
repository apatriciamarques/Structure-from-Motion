folders = {'bark', 'wall', 'graf', 'boat'};
data = struct();

% For each folder
for i = 1:4
    folderName = folders{i};
    folderPath = fullfile('data', folderName);
    folderData = struct(); 
    % Listing all images in the folder
    imageFiles = [dir(fullfile(folderPath, '*.ppm')); dir(fullfile(folderPath, '*.pgm'))];

    % For each image
    for j = 1:6
        imagePath = fullfile(folderPath, imageFiles(j).name);
        img = read_img(imagePath);
        
        % Convert to gray scale if needed
        if size(img, 3) == 3
            img_gray = rgb2gray(img);
        else
            img_gray = img;
        end

        % Extract SIFT features in each image
        pts = detectSIFTFeatures(img_gray);  
        [descs, validPts] = extractFeatures(img_gray, pts, 'Method', 'SIFT');  
        
        % Store image, descriptors and valid points
        folderData(j).img = img;
        folderData(j).descs = descs;
        folderData(j).validPts = validPts;
    end

    % Keep true H info
    H1_to = cell(1, 6);
    H1_to{1} = eye(3); 
    for j = 2:6
        H_filename = fullfile(folderPath, ['H1to' num2str(j) 'p']);
        H1_to{j} = readmatrix(H_filename);
    end
    
    % Store data and H_truth_1_to in the main data structure
    data.(folderName).folderData = folderData;
    data.(folderName).H1_to = H1_to;
end