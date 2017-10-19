function [rand8bit] =GenerateImage(x,y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
p=rand(x,y);
img=im2uint8(p);
imwrite(img,'rand8bit.tif','tif');
end

