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
