function [meanintensity] = MeanIntensity(size)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
GenerateImage(1024,1024);
ImageMask(size);
labeledImage=imread('ImageMask.tif');
grayscaleImage=imread('rand8bit.tif');
meanintensity = regionprops(labeledImage, grayscaleImage, 'MeanIntensity');
end

