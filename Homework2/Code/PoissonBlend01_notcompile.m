function [ V ] = PoissonBlend( source, mask, target, isMix)
  [src_x,src_y,src_z] = size(source);
  A = zeros(src_x*src_y,src_x*src_y,src_z);
  V = zeros(src_x*src_y,1,src_z);
  B = zeros(src_x*src_y,1,src_z);
  
  for z = 1:src_z
    for x = 1:src_x
      for y = 1:src_y        
        row = pix2row(x,y);
        if mask(x,y,z) == 1
          dict.left = 1;
          dict.right = 1;
          dict.top = 1;
          dict.bottom = 1;
          A(row,row,z) = 4;
          if mask(x+1,y,z) == 0
            dict.right = 0;
          elseif mask(x-1,y,z) == 0
            dict.left = 0;
          elseif mask(x,y+1,z) == 0
            dict.top = 0;
          elseif mask(x,y-1,z) == 0
            dict.bottom = 0;
          
          if dict.left == 1
            A(row,pix2row(x-1,y),z) == -1;
          else
            B(pix2row(x-1,y),1,z) += target(x-1,y,z); 
          
          if dict.right == 1
            A(row,pix2row(x+1,y),z) == -1;
          else
            B(pix2row(x+1,y),1,z) += target(x+1,y,z); 
            
          if dict.top == 1
            A(row,pix2row(x,y+1),z) == -1;
          else
            B(pix2row(x,y+1),1,z) += target(x,y+1,z);
          
          if dict.bottom == 1
            A(row,pix2row(x,y-1),z) == -1;
          else
            B(pix2row(x,y-1),1,z) += target(x,y-1,z);
        endif  
        B(row,1,z)  = 4*target(x,y,z) - target(x+1,y,z) - target(x-1,y,z) - target(x,y+1,z) - target(x,y-1,z);
      end
    end
   V(:,:,z) = B(:,:,Z)/A(:,:,z); 
  end 
end

function [ output ] = row2pix(row)
  [l,b,h] = size(source);
  y = floor(row/l);
  x = mod(row,l);
  output = [x,y]
endfunction

function [ output ] = pix2row(x,y)
  [l,b,h] = size(source);
  output = l*y + x;
endfunction 
          