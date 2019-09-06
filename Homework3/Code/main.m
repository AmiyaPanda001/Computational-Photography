clear; clc; close all;

%%% Assignment 3 - Starter code

% Setting up the input output paths
inputDir = '../Images/';
outputDir = '../Results/';


widthFac = 0.5; % To reduce the width, set this parameter to a value less than 1
heightFac = 1;  % To reduce the height, set this parameter to a value less than 1
N = 6; % number of images

for i = 1 : N
    
    printf('image_%02d begins...', i);
    tic();
    % Reading the input and mask (if exist)
    input = im2double(imread(sprintf('%s/image_%02d.jpg', inputDir, i)));
    
    maskFileName = sprintf('%s/mask_%02d.jpg', inputDir, i);
    if exist(maskFileName, 'file') == 2
        mask = im2double(imread(maskFileName));
        assert(prod(size(mask) == size(input)) == 1, 'size of mask and image does not match');
        #mask = logical(rgb2gray(mask));
    else
        mask = zeros(size(input, 1), size(input, 2));
    end

    % Performing seam carving. This is the part that you have to implement.
    output = SeamCarve(input, widthFac, heightFac, mask);

    % Writing the result
    imwrite(output, sprintf('%s/result_%02d_%02dx%02d.jpg', outputDir, i, widthFac * size(input, 2), heightFac * size(input, 1)));
    toc();
    printf('image_%02d ends...', i);
end