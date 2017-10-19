function [m] = cleanup(img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


I=imdilate(img,strel('disk',1));

clean=regionprops(I,'Area','Centroid','Image','PixelIdxList');
cleanAreas=[clean.Area];
AreaAverage=mean(cleanAreas);
Areastdev=std(cleanAreas);

ids=find(cleanAreas<(Areastdev));
lids=length(ids);

for ii=1:lids
I(clean(ids(ii)).PixelIdxList)=false; 
end
m=imdilate(I,strel('disk',6));
end

