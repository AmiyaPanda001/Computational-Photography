function [lnE] = reconstruct_hdr(image,g,B,w,ch)

[x_max,y_max,chnl,p] = size(image);

for i = 1:x_max
  for j = 1:y_max
    tot_w = 0;
    g_w_tot = 0;
    for k = 1:p
       pic = image(i,j,ch,k);
       if pic == 0
         pic = 1;
       end
       temp_w = w(pic); 
       tot_w += temp_w;
       #disp(image(i,j,ch,k));
       temp_g = g(pic);
       g_w_temp  = temp_w*(temp_g - B(k));
       g_w_tot += g_w_temp;
      
    end
    
    lnE(i,j) = g_w_tot/tot_w;
  end
end
endfunction