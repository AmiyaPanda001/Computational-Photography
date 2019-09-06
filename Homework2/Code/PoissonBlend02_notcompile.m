function [ V ] = PoissonBlend( source, mask, target, isMix)
  
   [src_x,src_y,src_z] = size(source);
 
   A = zeros(src_x*src_y,src_x*src_y,src_z);
 
   V = zeros(src_x*src_y,1,src_z);
   B = zeros(src_x*src_y,1,src_z);
  
 
   for z = 1:src_z
    
     for x = 1:src_x
      
       for y = 1:src_y        
        
         row = pix2row(x,y);
	 if border(1,1) == 3
          if border(1,2) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x-1,y),z) = -1;
            A(row,pix2row(x,y+1),z) = -1;
            A(row,pix2row(x,y-1),z) = -1;
            B(pix2row(x+1,y),1) += target(x+1,y,z);
          elseif border(1,3) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x+1,y),z) = -1;
            A(row,pix2row(x,y+1),z) = -1;
            A(row,pix2row(x,y-1),z) = -1;
            B(pix2row(x-1,y),1) += target(x-1,y,z);
          elseif border(1,4) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x+1,y),z) = -1;
            A(row,pix2row(x-1,y),z) = -1;
            A(row,pix2row(x,y-1),z) = -1;
            B(pix2row(x,y+1),1) += target(x,y+1,z);
          elseif border(1,4) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x+1,y),z) = -1;
            A(row,pix2row(x-1,y),z) = -1;
            A(row,pix2row(x,y+1),z) = -1;
            B(pix2row(x,y-1),1) += target(x,y-1,z);
          endif
        
        else if border(1,1) == 2
          if border(1,2) != 1 && border(1,3) != 1
		        A(row,row,z) = 4;
            A(row,pix2row(x,y+1),z) = -1;
            A(row,pix2row(x,y-1),z) = -1;
            B(pix2row(x,y+1),1) += target(x,y+1,z);
            B(pix2row(x,y-1),1) += target(x,y-1,z);
          else if border(1,2) != 1 && border(1,4) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x-1,y),z) = -1;
            A(row,pix2row(x,y-1),z) = -1;
            B(pix2row(x,y+1),1) += target(x,y+1,z);
            B(pix2row(x+1,y),1) += target(x+1,y,z);
          else if border(1,2) != 1 && border(1,5) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x,y+1),z) = -1;
            A(row,pix2row(x-1,y),z) = -1;
            B(pix2row(x,y-1),1) += target(x,y-1,z);
            B(pix2row(x-1,y),1) += target(x-1,y,z);
          else if border(1,3) != 1 && border(1,4) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x+1,y),z) = -1;
            A(row,pix2row(x,y-1),z) = -1;
            B(pix2row(x,y+1),1) += target(x,y+1,z);
            B(pix2row(x-1,y),1) += target(x-1,y,z);
          else if border(1,3) != 1 && border(1,5) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x+1,y),z) = -1;
            A(row,pix2row(x,y+1),z) = -1;
            B(pix2row(x,y+1),1) += target(x,y+1,z);
            B(pix2row(x-1,y),1) += target(x-1,y,z);
          else if border(1,4) != 1 && border(1,5) != 1
            A(row,row,z) = 4;
            A(row,pix2row(x+1,y),z) = -1;
            A(row,pix2row(x-1,y),z) = -1;
            B(pix2row(x,y+1),1) += target(x,y+1,z);
            B(pix2row(x,y-1),1) += target(x,y-1,z);
          endif
        
        else if border(1,1) == 1
          if border(1,2) == 1
            A(row,row,z) = 4;
            A(row,pix2row(x+1,y),z) = -1;
            B(pix2row(x,y-1),1) += target(x,y-1,z);
            B(pix2row(x,y+1),1) += target(x,y+1,z);
            B(pix2row(x-1,y),1) += target(x-1,y,z);
          elseif border(1,3) == 1
            A(row,row,z) = 4;
            A(row,pix2row(x-1,y),z) = -1;
            B(pix2row(x+1,y),1) += target(x+1,y,z);
            B(pix2row(x,y+1),1) += target(x,y+1,z);
            B(pix2row(x,y-1),1) += target(x,y-1,z);
          elseif border(1,5) == 1
            A(row,row,z) = 4;
            A(row,pix2row(x,y-1),z) = -1;
            B(pix2row(x+1,y),1) += target(x+1,y,z);
            B(pix2row(x-1,y),1) += target(x-1,y,z);
            B(pix2row(x,y+1),1) += target(x,y+1,z);
          elseif border(1,4) == 1
            A(row,row,z) = 4;
            A(row,pix2row(x,y+1),z) = -1;
            B(pix2row(x+1,y),1) += target(x+1,y,z);
            B(pix2row(x-1,y),1) += target(x-1,y,z);
            B(pix2row(x,y-1),1) += target(x,y-1,z);
          endif
          
        else if border(1,1) == 0
          A(row,row,z) = 1;
        endif
        
        B(row,1) = 4*target(x,y,z) - target(x+1,y,z) - target(x,y+1,z) - target(x-1,y,z) - target(x,y-1,z);
        
      endfor
    endfor
    V(:,:,z) = B(:,:,z)/A(:,:,z);
  endfor 
  output = V;
endfunction

function [ output ] = isborder( x, y, z,mask)
  
  rec = zeros(1,4);
  r = rec(1,1)= mask(x+1,y,z);
  l = rec(1,2)= mask(x-1,y,z);
  t = rec(1,3)= mask(x,y+1,z);
  b = rec(1,4)= mask(x,y-1,z);

  count = 0;

  for i = 1:4
    if rec(1,i) != 1
      count += 1;
    endif
  endfor
  
  output = [count,r,l,t,b]; 
endfunction


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