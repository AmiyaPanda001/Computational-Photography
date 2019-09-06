clear; clc;

pkg load image;

%%% Assignment 1 


%%% 

% Setting the input output file path
imageDir = 'C:\Users\Amiya\Desktop\CSCE_689\Assignment_1\StarterCode-Images\Images';
imageName = '\turkmen.tif';
outDir = 'C:\Users\Amiya\Desktop\CSCE_689\Assignment_1\StarterCode-Images\Results';

% Reading the glass plate image
glassPlate = im2double(imread([imageDir, imageName]));

% Separating the glass image into R, G, and B channels.
glassHeight = size(glassPlate, 1);
height = floor(glassHeight / 3);

b = glassPlate(1:height, :);
g = glassPlate(height+1:2*height, :);
r = glassPlate(2*height+1:3*height, :);

%cropping image

b = crop(b,0.1);
g = crop(g,0.1);
r = crop(r,0.1);

% The main part of the code. Calls FindShift_pyramid function

tic;%start timer

rShift = Findpyramid_shift(r, b);
gShift = Findpyramid_shift(g, b);

%display final shift co-ordinates
disp('rshift'); disp(rShift);
disp('gshift'); disp(gShift);

% Shifting the images using the obtained shift values
finalB = b;
finalG = circshift(g, gShift);
finalR = circshift(r, rShift);

% Putting together the aligned channels to form the color image
finalImage = cat(3, finalR, finalG, finalB);

toc;%stop timer

% Writing the image to the Results folder
imwrite(finalImage, [outDir, imageName]);
