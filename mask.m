function [m] = mask( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

threshold=mean(prctile(img,90)); %Find an arbitrary threshold at the 90th Percentile
m=img>threshold;

end

