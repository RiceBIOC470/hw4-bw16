function [average] = PlotMeanIntensity(Size)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
CircleSize=[1:Size];
MeanIntensities=zeros(Size,1);
StandardDeviation=zeros(Size,1);
for i=1:Size
    Intensity=MeanIntensity(i);
    Int=Intensity.MeanIntensity;
    MeanIntensities(i,1)=mean(Int);
    StandardDeviation(i,1)=std(Int);
end
errorbar(CircleSize,MeanIntensities,StandardDeviation);
xlabel('CircleSize');
ylabel('MeanIntensity');
end

