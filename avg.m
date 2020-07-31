function out = avg(Images)   

      out = zeros(768, 1);
      Image = (Images);
      out(1:256) = imhist(Image(:, :, 1));
      out(257:512) = imhist(Image(:, :, 2));
      out(513:768) = imhist(Image(:, :, 3));
   
end


