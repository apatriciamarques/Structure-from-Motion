function img = read_img(path_to_file)
    raw_image = imread(path_to_file); 
    img = im2double(raw_image);
end