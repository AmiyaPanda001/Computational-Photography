function ncc = Findncc(I1, I2)
  
  % finds the normalised cross correlation between two images and gives the output.
  
  ncc = dot(I1(:),I2(:))/norm(I1(:))/norm(I2(:));

endfunction


