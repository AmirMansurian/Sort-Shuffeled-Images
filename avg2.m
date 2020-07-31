function out = avg2(Images)   

      [row, col, dim] = size(Images);
      out = zeros(4, row*3);
      Image = (Images);
          
      I = imfilter(Image, fspecial('Average', [1, 5]));
      
      out(1, 1:row) = I(1, :, 1);
      out(1, row+1:2*row) = I(1, :, 2);
      out(1, 2*row+1:3*row) = I(1, :, 3);
      
      out(3, 1:row) = I(row, :, 1);
      out(3, row+1:2*row) = I(row, :, 2);
      out(3, 2*row+1:3*row) = I(row, :, 3);
      
      I = imfilter(Image, fspecial('Average', [5, 1]));
      
      out(2, 1:row) = I(:, col, 1);
      out(2, row+1:2*row) = I(:, col, 2);
      out(2, 2*row+1:3*row) = I(:, col, 3);
      
      out(4, 1:row) = I(:, 1, 1);
      out(4, row+1:2*row) = I(:, 1, 2);
      out(4, 2*row+1:3*row) = I(:, 1, 3);

end


