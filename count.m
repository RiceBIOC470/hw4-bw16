function [number,meanarea,meanintensity] = count(img1,img2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

measurements=regionprops(img2,img1, 'MeanIntensity','FilledArea');
number=length(measurements);

meanints(1:number)=measurements(1:number).MeanIntensity;
meanintensity=mean(meanints);

meanfil(1:number)=measurements(1:number).FilledArea;
meanarea=mean(meanfil);

end

