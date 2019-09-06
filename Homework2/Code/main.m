clear; clc; close all;
pkg load image;
%%% Assignment 2 - Starter code
% Code from James Hays

% Setting up the input output paths
data_dir = '../exp/';
out_dir = '../exp/';

% false for source gradient, true for mixing gradients
isMix = false;

N = 7;
offset = cell(N,1);
offset{1} = [210, 100];



    
source = im2double(imread(sprintf('%s/source1.jpg',data_dir)));
mask = im2double(imread(sprintf('%s/mask1.jpg',data_dir)));
target = im2double(imread(sprintf('%s/target.jpg',data_dir)));
    
    % cleaning up the mask
mask(mask < 0.5) = 0;
mask(mask >= 0.5) = 1;
    
[l,b] = size(mask);
new_mask = zeros(l,b,3);
new_mask(:,:,1) = mask(:,:);
new_mask(:,:,2) = mask(:,:);
new_mask(:,:,3) = mask(:,:);
    
    % Align the source and mask using the provided offest
[source, mask1, target] = fiximages(source, new_mask, target, offset{1});
    
	
    % The main part of the code. Implement the PoissonBlend function
output = PoissonBlend1(source, mask1, target);
    
    % Writing the result
output = im2uint8(output);
imwrite(output,sprintf('%s/res_img2.jpg',out_dir));
    


