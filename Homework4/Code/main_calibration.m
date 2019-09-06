clear; clc; 

%%% Assignment 4 - Starter code

% Setting up the input output paths and the parameters
inputDir = '../Images/';
outputDir = '../Results/';

lambda = 50;
Zmin = 0;
Zmax = 255;

calibSetName = '0_Calib_Chapel';
tic();
% Parsing the input images to get the file names and corresponding exposure
% values
[filePaths, exposures, numExposures] = ParseFiles([inputDir, '/', calibSetName]);

B = log(exposures);
% Sample the images

inp = im2double(imread(char(filePaths(1))));
[x_max,y_max,chnl] = size(inp);
p = length(filePaths);

Z_r = zeros(80,p);
Z_g = zeros(80,p);
Z_b = zeros(80,p);

%taking 80 random samples
%code in octave...diffent function for matlab

rand_x = randi(x_max,1,80);
rand_y = randi(y_max,1,80);


for i = 1:80
  for j = 1:p

    pic = floor(im2double(imread(char(filePaths(j))))*255);
    Z_r(i,j) = pic(rand_x(i),rand_y(i),1);
    Z_g(i,j) = pic(rand_x(i),rand_y(i),2);
    Z_b(i,j) = pic(rand_x(i),rand_y(i),3);
            
  end
end

% Create the triangle function

function [output] = triangle(input)
  if input < (256/2)
    output = input;
  else
    output = 256 - input;
  endif
endfunction

%Tried passing array as function instead of "@triangle" to optimise 

for kt = 1:256
  if kt<128
    w(kt) = kt;
  else
    w(kt) = 256 - kt;
  endif
end
% Recover the camera response function using Debevec's optimization code (gsolve.m)

[g_r,lE_r]=gsolve(Z_r,B,lambda,w, Zmin, Zmax);
[g_g,lE_g]=gsolve(Z_g,B,lambda,w, Zmin, Zmax);
[g_b,lE_b]=gsolve(Z_b,B,lambda,w, Zmin, Zmax);    
disp('first part done ...');

%plotting camera response functions for different channels
 plot([g_r,g_g,g_b]);

%Stacking images in a single matrix for increasing speed

calibSetName = '1_Bicycles';
tic();
% Parsing the input images to get the file names and corresponding exposure
% values
[filePaths, exposures, numExposures] = ParseFiles([inputDir, '/', calibSetName]);

B = log(exposures);

inp = im2double(imread(char(filePaths(1))));
[x_max,y_max,chnl] = size(inp);
p = length(filePaths);

for a = 1:p
  image(:,:,:,a) = floor(im2double(imread(char(filePaths(a))))*255);
end

%fetching the logE for each channel

lnE_r = reconstruct_hdr(image,g_r,B,w,1);
disp('second part red done ...');
lnE_g = reconstruct_hdr(image,g_g,B,w,2);
disp('second part green done ...');
lnE_b = reconstruct_hdr(image,g_b,B,w,3);
disp('second part blue done ...');

%Extracting the E for r,g,b channels by applynig exponential operator

E_r = exp(lnE_r);
E_g = exp(lnE_g);
E_b = exp(lnE_b);

%show luminance mapping

LM(:,:,1) = E_r;
LM(:,:,2) = E_g;
LM(:,:,3) = E_b;

imshow(LM);
imwrite(LM, sprintf('%s/luminance_map_%s.jpg', outputDir,calibSetName));

%Global ton-mapping
E_r = global_tonemap(E_r);
E_g = global_tonemap(E_g);
E_b = global_tonemap(E_b);

disp('ton-mapping done ...');

%constructing the HDR image matrix

HDR(:,:,1) = E_r;
HDR(:,:,2) = E_g;
HDR(:,:,3) = E_b;

%show HDR image

imshow(HDR);
toc();

%save image

imwrite(HDR, sprintf('%s/result_%s.jpg', outputDir,calibSetName));