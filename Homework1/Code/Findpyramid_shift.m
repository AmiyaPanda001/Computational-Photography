function shift = Findpyramid_shift(img, ref)
  
  %A recursive approach is adopted to make the process fater. This is done by downsizing the
  %image and finding a shift with highest NCC and the upsampling the image. This is 
  %called Image Pyramid Approach.
  
  if size(img) < 400
        shift = FindShift(img,ref,15);
  else
	
        im_rescale = imresize(img, 0.5);
        ref_rescale = imresize(ref, 0.5);
    
        temp = Findpyramid_shift(im_rescale, ref_rescale);
        shift = FindShift(img,ref,0,2*temp(:,1),2*temp(:,2));
        
end