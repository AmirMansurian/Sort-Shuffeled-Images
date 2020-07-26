clc
clear all
close all

Path = 'res\';
Images_test = dir(Path);


Size = numel(Images_test)-5;
row = sqrt((5*Size)/8);
col = (8*row)/5;
Images = zeros(Size-4);
Solved = uint8(zeros(1200, 1920, 3));

counter = 1;
for i=1: 1: numel(Images_test)
    if Images_test(i).isdir == 0 && Images_test(i).name(1) == 'P'
        
        Images(counter) = i;
        counter = counter + 1;
    
    elseif Images_test(i).isdir ==0 && Images_test(i).name(1) == 'O' && Images_test(i).name(2) == 'u'
       Solved = imread([Path Images_test(i).name]); 
    end
end


features = zeros(Size - 4, 4, (1200/row)*3);
res = zeros(Size-4,1);
Filled = zeros(Size-4, 1);
Round  = zeros(row, col, 4, (1200/row)*3);
Selected = zeros(row, col);
Selected(1, 1) = 1;
Selected(1, col) = 1;
Selected(row, 1) = 1;
Selected(row, col) = 1;
Round(1, 1, :, :) = Diff(Solved(1:1200/row, 1:1920/col, :));
Round(1, col, :, :) = Diff(Solved(1:1200/row, 1920-(1920/col)+1:1920, :));   
Round(row, 1, :, :) = Diff(Solved(1200-(1200/row)+1:1200, 1:1920/col, :));   
Round(row, col, :, :) = Diff(Solved(1200-(1200/row)+1:1200, 1920-(1920/col)+1:1920, :)); 

for i=1: 1: Size-4
    features(i, :, :) = Diff(imread([Path Images_test(Images(i)).name]));
end


for i=1: 1: row
    for j=1: 1: col
        
        if Selected(i, j) == 0
                
               if j-1>0 && Selected(i, j-1) == 1
                   for h=1: 1: Size-4
                       temp  = 0;
                       if Filled(h) == 0
                           for k=1: 1: (1200/row)*3
                             temp = temp + abs(Round(i, j-1, 2, k) - features(h, 4, k));
                           end
                           
                           res(h, 1) = res(h, 1) + temp/(row*256)*3;
                       end
                   end
               end
               
                if j+1<col+1 && Selected(i, j+1) == 1 
                   for h=1: 1: Size-4
                       temp = 0;
                       if Filled(h) == 0
                           for k=1: 1: (1200/row)*3
                             temp = temp + abs(Round(i, j+1, 4, k) - features(h, 2, k));
                           end
                           res(h, 1) = res(h, 1) + temp/(row*256)*3;
                       end
                   end
                   
                end 
               
                if i-1>0 && Selected(i-1, j) == 1 
                   for h=1: 1: Size-4
                       temp = 0;
                       if Filled(h) == 0
                           for k=1: 1: (1200/row)*3
                             temp = temp + abs(Round(i-1, j, 3, k) - features(h, 1, k));
                           end
                           res(h, 1) = res(h, 1) + temp/(row*256)*3;
                       end
                   end
                   
                end 
               
                if i+1<row+1 && Selected(i+1, j) == 1 
                   for h=1: 1: Size-4
                       temp = 0;
                       if Filled(h) == 0
                           for k=1: 1: (1200/row)*3
                             temp = temp + abs(Round(i+1, j, 1, k) - features(h, 3, k));
                           end
                           res(h, 1) = res(h, 1) + temp/(row*256)*3;
                       end
                   end
                   
               end 

               
                   index = find(res == min(res));
                   res(index(1)) = 100000;
                   Selected(i, j) = 1;
                   Filled(index(1)) = 1;
                   Round(i, j, :, : ) = features(index(1), :, :);
                   Solved = Fill(i, j, Solved, imread([Path Images_test(Images(index(1))).name]));
                   
                  imshow(Solved);
                   pause(0.00005)
                   for k=1: 1: Size-4
                       if res(k) ~= 100000
                           res(k)=0;
                       end

                   end
        end
    end  
    
end




