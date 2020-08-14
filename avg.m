function out = avg(Image)   

      out = zeros(4, 768);
      [row, col, dim] = size(Image);
      
       out(1, 1:256) = imhist(Image(1:floor(row/4), :, 1));
      out(1, 257:512) = imhist(Image(1:floor(row/4), :, 2));
      out(1, 513:768) = imhist(Image(1:floor(row/4), :, 3));
      
      out(2, 1:256) = imhist(Image(:, 3*floor(col/4):col, 1));
      out(2, 257:512) = imhist(Image(:, 3*floor(col/4):col, 2));
      out(2, 513:768) = imhist(Image(:, 3*floor(col/4):col, 3));
      
      out(3, 1:256) = imhist(Image(3*floor(row/4):row, :, 1));
      out(3, 257:512) = imhist(Image(3*floor(row/4):row, :, 2));
      out(3, 513:768) = imhist(Image(3*floor(row/4):row, :, 3));
      
      out(4, 1:256) = imhist(Image(:, 1:floor(col/4), 1));
      out(4, 257:512) = imhist(Image(:, 1:floor(col/4), 2));
      out(4, 513:768) = imhist(Image(:, 1:floor(col/4), 3));
   
   
end


