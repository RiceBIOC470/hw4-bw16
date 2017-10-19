function [ result ] = BackgroundSub(img,x,y,r )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

img_sm=imfilter(img,fspecial('gaussian',x,y));
img_bg=imopen(img_sm,strel('disk',r));
result=imsubtract(img_sm,img_bg);

end

