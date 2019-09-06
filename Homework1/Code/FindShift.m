function shift = FindShift(im1, im2,x,xc=0,yc=0)

%finds the shift at which the NCC is the maximum with a brute force approach within the 
% window provided.

  movement = x;
  step = 1;
  best = 0;

  for y_s = -movement + yc:step:movement + yc
      for x_s = -movement + xc:step:movement + xc
        % move images around
          tmp = circshift(im1, [x_s y_s]);
       #match = sum(sum(tmp.*reference));
           match = Findncc(tmp,im2);
         
          if match > best
              best = match;
              shift = [x_s, y_s];
          end
      end
  end
