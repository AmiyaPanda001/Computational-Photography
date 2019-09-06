function [lnE] = reconstruct_hdr(g,w,ch)
%%% Assignment 4 - Starter code

% Setting up the input output paths and the parameters
inputDir = '../Images/';
outputDir = '../Results/';

sceneName = '0_Calib_Chapel';

% Parsing the input images to get the file names and corresponding exposure
% values
[filePaths, exposures, numExposures] = ParseFiles([inputDir, '/', sceneName]);
B = log(exposures);
% Reconstruct the irradiance of the scene using Eq. 6 in the Debevec paper
inp = im2double(imread(char(filePaths(1))));
[x_max,y_max,chnl] = size(inp);
p = length(filePaths);

for i = 1:x_max
  for j = 1:y_max
    for k = 1:p
      
       pic = floor(im2double(imread(char(filePaths(j))))*256);
       temp_w = w(pic(i,j,ch)); 
       tot_w += temp_w;
       
       temp_g = g(pic(i,j,ch));
       g_w_temp  = temp_w*(temp_g - B(k));
       g_w_tot += g_w_temp;
      
    end
    
    lnE(i,j) = g_w_tot/tot_w;
  end
end
endfunction

% Tonemap the image using the global operator
function [output]  = global_tonemap(input)
  
  for i = size(input,1)
    for j = size(input,2)
      output = input/(input + 1);
    end
  end

endfunction

% Tonemap the image using MATLAB's local operator

