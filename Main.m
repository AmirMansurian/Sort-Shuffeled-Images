function Solved = Main(Path, Images_test)

    counter = 0;
    for i=1: 1: numel(Images_test)
        if Images_test(i).isdir == 0 && Images_test(i).name(1) == 'P'
            counter = counter + 1;
        end
    end

    Size = counter+4;
    row = sqrt((5*Size)/8);
    col = (8*row)/5;
    width = 1200/row;
    height = 1920/col;
    Images = zeros(Size-4, 1);
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


    features = zeros(Size - 4, 4, width*3);
    features1 = zeros(Size - 4, 4, width*3);
    features2 = zeros(Size-4, 4, 3);
    features3 = zeros(Size-4, 4, 768);

    res = zeros(Size-4,1);
    res1 = zeros(Size-4,1);
    res2 = zeros(Size-4,1);
    res3 = zeros(Size-4,1);

    Filled = zeros(Size-4, 1);
    Round = zeros(row, col, 4, width*3);
    Round1 = zeros(row, col, 4, width*3);
    Round2 = zeros(row, col, 4, 3);
    Round3 = zeros(row, col, 4, 768);

    Selected = zeros(row, col);
    Selected(1, 1) = 1;
    Selected(1, col) = 1;
    Selected(row, 1) = 1;
    Selected(row, col) = 1;
    Round(1, 1, :, :) = Diff(Solved(1:1200/row, 1:1920/col, :));
    Round(1, col, :, :) = Diff(Solved(1:1200/row, 1920-(1920/col)+1:1920, :));   
    Round(row, 1, :, :) = Diff(Solved(1200-(1200/row)+1:1200, 1:1920/col, :));   
    Round(row, col, :, :) = Diff(Solved(1200-(1200/row)+1:1200, 1920-(1920/col)+1:1920, :));

    Round1(1, 1, :, :) = avg2(Solved(1:1200/row, 1:1920/col, :));
    Round1(1, col, :, :) = avg2(Solved(1:1200/row, 1920-(1920/col)+1:1920, :));   
    Round1(row, 1, :, :) = avg2(Solved(1200-(1200/row)+1:1200, 1:1920/col, :));   
    Round1(row, col, :, :) = avg2(Solved(1200-(1200/row)+1:1200, 1920-(1920/col)+1:1920, :));

    Round2(1, 1, :, :) = Corners(Solved(1:1200/row, 1:1920/col, :));
    Round2(1, col, :, :) = Corners(Solved(1:1200/row, 1920-(1920/col)+1:1920, :));   
    Round2(row, 1, :, :) = Corners(Solved(1200-(1200/row)+1:1200, 1:1920/col, :));   
    Round2(row, col, :, :) = Corners(Solved(1200-(1200/row)+1:1200, 1920-(1920/col)+1:1920, :)); 

    Round3(1, 1, :, :) = avg(Solved(1:1200/row, 1:1920/col, :));
    Round3(1, col, :, :) = avg(Solved(1:1200/row, 1920-(1920/col)+1:1920, :));   
    Round3(row, 1, :, :) = avg(Solved(1200-(1200/row)+1:1200, 1:1920/col, :));   
    Round3(row, col, :, :) = avg(Solved(1200-(1200/row)+1:1200, 1920-(1920/col)+1:1920, :)); 


    for i=1: 1: Size-4
        features(i, :, :) = Diff(imread([Path Images_test(Images(i)).name]));
        features1(i, :, :) = avg2(imread([Path Images_test(Images(i)).name]));
        features2(i, :, :) = Corners(imread([Path Images_test(Images(i)).name]));
        features3(i, :, :) = avg(imread([Path Images_test(Images(i)).name]));
    end



    coef = 1;
    alpha = 0.01;
    beta = 0.01; 
    delta = 0.1;    

       for i=1: 1: row
            for j=1: 1: col

                if Selected(i, j) == 0

                       if j-1>0 && Selected(i, j-1) == 1
                           for h=1: 1: Size-4
                               temp  = 0;
                               temp2 = 0;
                               if Filled(h) == 0
                                   for k=1: 1: (width)*3
                                     temp = temp + double(abs(double(Round(i, j-1, 2, k)) - double(features(h, 4, k))));
                                     temp2 = temp2 + double(abs(double(Round1(i, j-1, 2, k)) - double(features1(h, 4, k))));
                                   end
                                   res(h, 1) = res(h, 1) + (temp/(width*256*1*3));
                                   res1(h, 1) = res1(h, 1) + (temp2/(width*256*1*3));

                                   temp=0;
                                   for k=1: 1: 768
                                     temp = temp + double(abs(double(Round3(i, j-1, 2, k)) - double(features3(h, 4, k))));
                                   end
                                   res3(h, 1) = res3(h, 1) + (1)*(temp/(3*width*height*2));

                               end
                           end
                       end

                        if j+1<col+1 && Selected(i, j+1) == 1 
                           for h=1: 1: Size-4
                               temp = 0;
                               temp2 = 0;
                               if Filled(h) == 0
                                   for k=1: 1: width*3
                                     temp = temp + double(abs(double(Round(i, j+1, 4, k)) - double(features(h, 2, k))));
                                     temp2 = temp2 + double(abs(double(Round1(i, j+1, 4, k)) - double(features1(h, 2, k))));
                                   end
                                   res(h, 1) = res(h, 1) + (temp/(width*256*1*3));
                                   res1(h, 1) = res1(h, 1) + (temp2/(width*256*1*3));

                                   temp=0;
                                   for k=1: 1: 768
                                     temp = temp + double(abs(double(Round3(i, j+1, 4, k)) - double(features3(h, 2, k))));
                                   end
                                   res3(h, 1) = res3(h, 1) + (1)*(temp/(3*width*height*2));

                               end
                           end

                        end 

                        if i-1>0 && Selected(i-1, j) == 1 
                           for h=1: 1: Size-4
                               temp = 0;
                               temp2 = 0;
                               if Filled(h) == 0
                                   for k=1: 1: width*3
                                     temp = temp + double(abs(double(Round(i-1, j, 3, k)) - double(features(h, 1, k))));
                                     temp2 = temp2 + double(abs(double(Round1(i-1, j, 3, k)) - double(features1(h, 1, k))));
                                   end
                                   res(h, 1) = res(h, 1) + (temp/(width*256*1*3));
                                   res1(h, 1) = res1(h, 1) + (temp2/(width*256*1*3));

                                   temp=0;
                                   for k=1: 1: 768
                                     temp = temp + double(abs(double(Round3(i-1, j, 3, k)) - double(features3(h, 1, k))));
                                   end
                                   res3(h, 1) = res3(h, 1) + (1)*(temp/(3*width*height*2));

                               end
                           end

                        end 

                        if i+1<row+1 && Selected(i+1, j) == 1 
                           for h=1: 1: Size-4
                               temp = 0;
                               temp2 = 0;
                               if Filled(h) == 0
                                   for k=1: 1: width*3
                                     temp = temp + double(abs(double(Round(i+1, j, 1, k)) - double(features(h, 3, k))));
                                     temp2 = temp2 + double(abs(double(Round1(i+1, j, 1, k)) - double(features1(h, 3, k))));
                                   end
                                   res(h, 1) = res(h, 1) + (temp/(width*256*1*3));
                                   res1(h, 1) = res1(h, 1) + (temp2/(width*256*1*3));

                                   temp=0;
                                   for k=1: 1: 768
                                     temp = temp + double(abs(double(Round3(i+1, j, 1, k)) - double(features3(h, 3, k))));
                                   end
                                   res3(h, 1) = res3(h, 1) + (1)*(temp/(3*width*height*2));

                               end
                           end

                        end 



                        if j-1>0 && i+1<row+1 && Selected(i+1, j-1) == 1
                           for h=1: 1: Size-4
                               temp  = 0;
                               if Filled(h) == 0
                                   for k=1: 1: 3
                                     temp = temp + double(abs(double(Round2(i+1, j-1, 2, k)) - double(features2(h, 4, k))));
                                   end
                                   res2(h, 1) = res2(h, 1) + (1)*(temp/(3*256*1));
                               end
                           end
                       end

                        if j+1<col+1 && i-1>0 && Selected(i-1, j+1) == 1 
                           for h=1: 1: Size-4
                               temp = 0;
                               if Filled(h) == 0
                                   for k=1: 1: 3
                                     temp = temp + double(abs(double(Round2(i-1, j+1, 4, k)) - double(features2(h, 2, k))));
                                   end
                                  res2(h, 1) = res2(h, 1) + (1)*(temp/(3*256*1));
                               end
                           end

                        end 

                        if i-1>0 && j-1 >0 && Selected(i-1, j-1) == 1 
                           for h=1: 1: Size-4
                               temp = 0;
                               if Filled(h) == 0
                                   for k=1: 1: 3
                                     temp = temp + double(abs(double(Round2(i-1, j-1, 3, k)) - double(features2(h, 1, k))));
                                   end
                                   res2(h, 1) = res2(h, 1) + (7*temp/(3*256*1));
                               end
                           end

                        end 

                        if i+1<row+1 && j+1<col+1 && Selected(i+1, j+1) == 1 
                           for h=1: 1: Size-4
                               temp = 0;
                               if Filled(h) == 0
                                   for k=1: 1: 3
                                     temp = temp + double(abs(double(Round2(i+1, j+1, 1, k)) - double(features2(h, 3, k))));
                                   end
                                   res2(h, 1) = res2(h, 1) + (temp/(3*256*1));

                               end
                           end

                        end

                        for c=1: 1: Size-4
                            if Filled(c) == 0
                                res(c, 1) = coef*res(c, 1) + (beta*res3(c, 1)) + (alpha*res2(c, 1)) + (delta*res1(c, 1));
                            end
                        end

                           index = find(res == min(res));
                           res(index(1)) = 100000;
                           res2(index(1)) = 100000;
                           res3(index(1)) = 100000;
                           res1(index(1)) = 100000;
                           Selected(i, j) = 1;
                           Filled(index(1)) = 1;
                           Round(i, j, :, : ) = features(index(1), :, :);
                           Round1(i, j, :, : ) = features1(index(1), :, :);
                           Round2(i, j, :, : ) = features2(index(1), :, :);
                           Round3(i, j, :, : ) = features3(index(1), :, :);
                           Solved = Fill(i, j, Solved, imread([Path Images_test(Images(index(1))).name]));

                          imshow(Solved);
                          pause(0.00005)
                           for k=1: 1: Size-4
                               if res(k) ~= 100000
                                   res(k)=0;
                                   res1(k)=0;
                                   res2(k)=0;
                                   res3(k)=0;
                               end

                           end
                end
            end  

        end
   
    imshow(Solved);
    
   
