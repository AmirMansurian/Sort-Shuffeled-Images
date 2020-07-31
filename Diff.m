function out = Diff(Image)   

      [row, col, dim] = size(Image);
      out = zeros(4, row*3);
    
      out(1, 1:row) = Image(1, :, 1);
      out(1, row+1:2*row) = Image(1, :, 2);
      out(1, 2*row+1:3*row) = Image(1, :, 3);
     % out(1, 3*row+1:4*row) = Image(2, :, 1);
     % out(1, 4*row+1:5*row) = Image(2, :, 2);
     % out(1, 5*row+1:6*row) = Image(2, :, 3);
     % out(1, 6*row+1:7*row) = Image(1, :, 1);
      %out(1, 7*row+1:8*row) = Image(1, :, 2);
      %out(1, 8*row+1:9*row) = Image(1, :, 3);
      
      out(2, 1:row) = Image(:, col, 1);
      out(2, row+1:2*row) = Image(:, col, 2);
      out(2, 2*row+1:3*row) = Image(:, col, 3);
     % out(2, 3*row+1:4*row) = Image(:, col-1, 1);
     % out(2, 4*row+1:5*row) = Image(:, col-1, 2);
     % out(2, 5*row+1:6*row) = Image(:, col-1, 3);
      %out(2, 6*row+1:7*row) = Image(:, col, 1);
      %out(2, 7*row+1:8*row) = Image(:, col, 2);
      %out(2, 8*row+1:9*row) = Image(:, col, 3);
      
      out(3, 1:row) = Image(row, :, 1);
      out(3, row+1:2*row) = Image(row, :, 2);
      out(3, 2*row+1:3*row) = Image(row, :, 3);
     % out(3, 3*row+1:4*row) = Image(row-1, :, 1);
     % out(3, 4*row+1:5*row) = Image(row-1, :, 2);
     % out(3, 5*row+1:6*row) = Image(row-1, :, 3);
      %out(3, 6*row+1:7*row) = Image(row, :, 1);
      %out(3, 7*row+1:8*row) = Image(row, :, 2);
      %out(3, 8*row+1:9*row) = Image(row, :, 3);
      
      out(4, 1:row) = Image(:, 1, 1);
      out(4, row+1:2*row) = Image(:, 1, 2);
      out(4, 2*row+1:3*row) = Image(:, 1, 3);
      %out(4, 3*row+1:4*row) = Image(:, 2, 1);
      %out(4, 4*row+1:5*row) = Image(:, 2, 2);
      %out(4, 5*row+1:6*row) = Image(:, 2, 3);
      %out(4, 6*row+1:7*row) = Image(:, 1, 1);
      %out(4, 7*row+1:8*row) = Image(:, 1, 2);
      %out(4, 8*row+1:9*row) = Image(:, 1, 3);
end
