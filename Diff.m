function out = Diff(Image)   

      [row, col, dim] = size(Image);
      out = zeros(4, row*3);
    
      out(1, 1:row) = Image(1, :, 1);
      out(1, row+1:2*row) = Image(1, :, 2);
      out(1, 2*row+1:3*row) = Image(1, :, 3);
      
      out(2, 1:row) = Image(:, col, 1);
      out(2, row+1:2*row) = Image(:, col, 2);
      out(2, 2*row+1:3*row) = Image(:, col, 3);
      
      out(3, 1:row) = Image(row, :, 1);
      out(3, row+1:2*row) = Image(row, :, 2);
      out(3, 2*row+1:3*row) = Image(row, :, 3);
      
      out(4, 1:row) = Image(:, 1, 1);
      out(4, row+1:2*row) = Image(:, 1, 2);
      out(4, 2*row+1:3*row) = Image(:, 1, 3);
end
