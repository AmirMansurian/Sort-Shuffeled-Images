function out = Corners (Image)

    [row, col, dim] = size(Image);
    out = uint8(zeros(4, 3));
    
    out(1, 1) = (Image(1, 1, 1) + Image(1, 2, 1) + Image(2, 1, 1) + Image(1, 2, 1))/4;
    out(1, 2) = (Image(1, 1, 2) + Image(1, 2, 2) + Image(2, 1, 2) + Image(1, 2, 2))/4;
    out(1, 3) = (Image(1, 1, 3) + Image(1, 2, 3) + Image(2, 1, 3) + Image(1, 2, 3))/4;
    
    out(4, 1) = (Image(row, 1, 1) + Image(row-1, 1, 1) + Image(row, 2, 1) + Image(row-1, 2, 1))/4;
    out(4, 2) = (Image(row, 1, 2) + Image(row-1, 1, 2) + Image(row, 2, 2) + Image(row-1, 2, 2))/4;
    out(4, 3) = (Image(row, 1, 3) + Image(row-1, 1, 3) + Image(row, 2, 3) + Image(row-1, 2, 3))/4;
    
    out(2, 1) = (Image(1, col, 1) + Image(1, col-1, 1) + Image(2, col, 1) + Image(2, col-1, 1))/4;
    out(2, 3) = (Image(1, col, 3) + Image(1, col-1, 3) + Image(2, col, 3) + Image(2, col-1, 3))/4;
    out(2, 2) = (Image(1, col, 2) + Image(1, col-1, 2) + Image(2, col, 2) + Image(2, col-1, 2))/4;
    
    out(3, 2) = (Image(row, col, 2) + Image(row, col, 2) + Image(row, col, 2) + Image(row, col, 2))/4;
    out(3, 1) = (Image(row, col, 1) + Image(row, col, 1) + Image(row, col, 1) + Image(row, col, 1))/4;
    out(3, 3) = (Image(row, col, 3) + Image(row, col, 3) + Image(row, col, 3) + Image(row, col, 3))/4;
    
    
    
end