function cropped = crop(img, fraction)
  
  %crops the input image by deleting the given fractions of the image from each side.
 % This is done to increase efficiency by decreasing the effect of the boundary.
	
  [width, height] = size(img);
	marginw = round(fraction * width);
    marginh = round(fraction * height);
    cropped = img(marginw:width-marginw, marginh:height-marginh);
end