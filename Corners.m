function out = Corners (Image)

    [row, col, dim] = size(Image);
    out = uint8(zeros(4, 3));
    
      out(1, 1) = (Image(1, 1, 1) );
    out(1, 2) = (Image(1, 1, 2));
    out(1, 3) = (Image(1, 1, 3) );
    
    out(4, 1) = (Image(row, 1, 1) );
    out(4, 2) = (Image(row, 1, 2));
    out(4, 3) = (Image(row, 1, 3) );
    
    out(2, 1) = (Image(1, col, 1) );
    out(2, 3) = (Image(1, col, 3) );
    out(2, 2) = (Image(1, col, 2) );
    
    out(3, 2) = (Image(row, col, 2));
    out(3, 1) = (Image(row, col, 1) );
    out(3, 3) = (Image(row, col, 3));
    
    
    
    
end