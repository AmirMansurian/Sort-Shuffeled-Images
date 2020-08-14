clc 
clear all
close all

Path = 'C:\Users\Amir\Desktop\Puzzle\Puzzle_3_40\';          % <---------------- Please Enter Path of Images here 

Images_test = dir(Path);

Output = Main(Path, Images_test);

for i=1: 1: numel(Images_test)
    
    if Images_test(i).isdir == 0 && Images_test(i).name == "Original.tif"
        
       Original = imread([Path Images_test(i).name]); 
        
    end

end

MSE = MSE(Output, Original)
