function output = SeamCarve(input, widthFac, heightFac, mask)
% Main seam carving function. This is done in three main parts: 1)
% computing the energy function, 2) finding optimal seam, and 3) removing
% the seam. The three parts are repeated until the desired size is reached.

assert(widthFac == 1 || heightFac == 1, 'Changing both width and height is not supported!');
assert(widthFac <= 1 && heightFac <= 1, 'Increasing the size is not supported!');


%output = imresize(input, [heightFac*size(input, 1) widthFac*size(input, 2)]);



temp = 0;

if widthFac == 1
  if size(input,3) == 3
    input = permute(input, [2 1 3]);
  else
    input = transpose(input);
  endif
  mask = transpose(mask);
  temp = widthFac;
  widthFac = heightFac;
endif



for num = 1:(1-widthFac)*size(input, 2)
  
  %finding the energy function matrix M for the 3d input image.
  if max(max(mask)) == 0
    temp_img = rgb2gray(input);
    [dy, dx] = gradient(temp_img);
    temp_img = abs(dy) + abs(dx);
    M = temp_img;
  else
    temp_img = input;
    %[dym,dym] = gradient(mask)
    alpha = 10;
    [dy, dx] = gradient(temp_img);
    temp_img = abs(dy + alpha*mask) + abs(dx + alpha*mask);
    M = temp_img;
    
  endif
  
  
  %disp('energy matrix construction begins...');
  %tic();
 
  %traversing the energy matrix M and updating the energy of the pixels comming in 
  %the path.
  %disp(size(temp_img));
  %disp(size(input));
  %disp(size(M));
  %disp(M);
  for y = 2:size(temp_img, 1)
    for x = 1:size(temp_img, 2)
      %disp(min(M(y - 1,x), M( y - 1,x + 1)));
      
      if x == 1 
        M(y, x) = M(y, x) + min(M(y - 1,x), M( y - 1,x + 1));
      elseif x == size(temp_img, 2)
        M(y, x) = M(y, x) + min(M(y - 1,x), M( y - 1,x - 1));
      else
        M(y, x) = M(y, x) + min([M(y - 1,x), M( y - 1,x + 1),M( y - 1,x - 1)]);
      
      endif
    
    endfor
  endfor
  
  %disp('energy matrix construction ends...');
  %toc();
  
  %Backtracking to find the optimal seam
  
  %disp('backtracking begins...');
  %tic();
  
  [value,index] = min(M(size(M,1),:));
  seam = zeros(size(M,1),1);
  seam(size(M,1),1) = index;
  %disp(size(M,2));
  x = index;
	
  for y = size(M,1):-1:2
		
	  if x == 1
		  [temp_val,temp_x] = min([M(y-1,x), M(y-1,x+1)]);
		  if temp_x == 2
		    x = x + 1;
      endif
	  elseif x == size(M,2)
		  [temp_val,temp_x] = min([M(y-1,x), M(y-1,x-1)]);
		  if temp_x == 2
			  x = x - 1;
      endif
	  else
		  [temp_val,temp_x] = min([M(y-1,x), M(y-1,x-1),M(y-1,x+1)]);
		  if temp_x == 2
			  x = x - 1;
		  elseif temp_x == 3
			  x = x + 1;
      endif
	  endif
	
    seam(y-1,1) = x;
  
  endfor

  %disp('backtracking ends...');
  %toc();

  %disp('updating input image begins...');
  %tic();

  
  %deleting the seam from the image and updating the input for the next cycle.
  
  
  [v, h, d] = size(input);
  input_temp = zeros(v, h - 1, d);
  mask_temp = zeros(v, h - 1);
  for y=1:size(input,1)
    input_temp(y,:,:) = input(y,[1:seam(y)-1,seam(y)+1:h],:);
    mask_temp(y,:) = mask(y,[1:seam(y)-1,seam(y)+1:h]);
  endfor;
	
	input = zeros(v, h - 1, d);
  mask = zeros(v, h - 1, d);
	input = input_temp;
  mask = mask_temp;
  
  %disp('updating input image begins...');
  %toc();

endfor


if temp == 1
  if size(input,3) == 3
	  output = permute(input, [2 1 3]);
  else
    output = transpose(input);
  endif
else
  output = input;
endif