function [imagemask] = ImageMask(size)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    img=false(1024);
    for i=1:20
        x=randi(1024);
        y=randi(1024);
        img(x,y)=true;
    end
        imgx2 = im2double(img);
        img_mask = imgx2 > 1000;
        img=imdilate(img,strel('sphere',size));
    imwrite(img,'ImageMask.tif','tif');
end

