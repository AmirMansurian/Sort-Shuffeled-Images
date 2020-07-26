clc
clear all
close all

Path = 'Puzzle_2_160\';

Images = dir(Path);

I = imread([Path Images(7).name]);

temp = uint8(zeros(60, 60, 3));
counter = 1;
for i=1: 1: 20
    for j=1: 1: 32
        
        row = 60*(i-1);
        col = 60*(j-1);
        temp = I (row+1:row+60, col+1:col+60, :);
        name = ['P' int2str(counter) '.tif'];
        imwrite(temp, name);
        counter = counter + 1;
    end
end