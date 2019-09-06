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