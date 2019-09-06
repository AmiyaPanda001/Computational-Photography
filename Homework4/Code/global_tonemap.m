function [output]  = global_tonemap(input)
  
  for i = 1:size(input,1)
    for j = 1:size(input,2)
      output(i,j) = (0.5*input(i,j))/(0.5*input(i,j) + 1);
    end
  end

endfunction