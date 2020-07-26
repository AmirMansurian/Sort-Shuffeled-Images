function out = Fill(r, c, Solved, Image)

    [roww, coll, dim] = size(Image);

    row = roww * (r-1) + 1;
    col = coll * (c-1) + 1;
    
    for i=row: 1: row+roww-1
        for j=col: 1: col+coll-1

            Solved(i, j, :) = Image(i-row+1, j-col+1, :);
            
        end
    end

    out = Solved;
    
end