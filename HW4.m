%HW4
%% 
% Problem 1. 

% 1. Write a function to generate an 8-bit image of size 1024x1024 with a random value 
% of the intensity in each pixel. Call your image rand8bit.tif. 

GenerateImage(1024,1024);
I=imread('rand8bit.tif');
figure(1);
imshow(I);

% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations

ImageMask(20);
I=imread('ImageMask.tif');
figure(2);
imshow(I);

% 3. Write a function that takes the image from (1) and the binary mask
% from (2) and returns a vector of mean intensities of each circle (hint: use regionprops).

MeanIntensity(20);

%
% 4. Plot the mean and standard deviation of the values in your output
% vector as a function of circle size. Explain your results. 

PlotMeanIntensity(20); 

%%

%Problem 2. Here is some data showing an NFKB reporter in ovarian cancer
%cells. 
%https://www.dropbox.com/sh/2dnyzq8800npke8/AABoG3TI6v7yTcL_bOnKTzyja?dl=0
%There are two files, each of which have multiple timepoints, z
%slices and channels. One channel marks the cell nuclei and the other
%contains the reporter which moves into the nucleus when the pathway is
%active. 
%
%Part 1. Use Fiji to import both data files, take maximum intensity
%projections in the z direction, concatentate the files, display both
%channels together with appropriate look up tables, and save the result as
%a movie in .avi format. Put comments in this file explaining the commands
%you used and save your .avi file in your repository (low quality ok for
%space). 

% File>Import>TIFF Virtual Stack to import both images
%Image>Stacks>Zproject>Max Intensity function to adjust to maximum
%intensity of each image
%Image>Stacks>Tools>Concatonate to concatenate imagesd, using MAX_nfkb_movie1.tif 
%MAX_nfkb_movie2.tif as two image inputs. 
%Image>Color>Merge Channels> selecting Channel 1 as green and Channel 2 as red. 
%saved the image using FILE>Save As>AVI

%Part 2. Perform the same operations as in part 1 but use MATLAB code. You don't
%need to save the result in your repository, just the code that produces
%it. 
V=VideoWriter('Matlab.avi');
open(V);

reader1=bfGetReader('nfkb_movie1.tif');
reader2=bfGetReader('nfkb_movie2.tif');

nt=reader1.getSizeT; 
nz=reader1.getSizeZ; 
nt2=reader2.getSizeT; 
nz2=reader2.getSizeZ;

for i=1:nt
    iplane=reader1.getIndex(0,0,i-1)+1;
    img_max2=bfGetPlane(reader1,iplane);
    iplane2_2=reader1.getIndex(0,1,i-1)+1;
    img_max1_2=bfGetPlane(reader1,iplane2_2);

    for k=2:nz
        iplane1=reader1.getIndex(k-1,0,i-1)+1;
        imgnow1=bfGetPlane(reader1,iplane1);
        img_max2=max(img_max2,imgnow1);
        iplane2_2=reader1.getIndex(k-1,1,i-1)+1;
        imgnow1_2=bfGetPlane(reader1,iplane2_2);
        img_max1_2=max(img_max1_2,imgnow1_2);
    end
        
    cattempimg=cat(3,imadjust(img_max2),imadjust(img_max1_2),zeros(size(img_max2)));
    cattempimg_double=im2double(cattempimg);
    writeVideo(V,cattempimg_double);
        
end


for j=1:nt2
    iplane2=reader2.getIndex(0,0,j-1)+1;
    img_max2=bfGetPlane(reader2,iplane2);
    iplane2_2=reader2.getIndex(0,1,j-1)+1;
    img_max2_2=bfGetPlane(reader2,iplane2_2);

    for k=2:nz2
        iplane2=reader2.getIndex(k-1,0,j-1)+1;
        imgnow2_1=bfGetPlane(reader2,iplane2);
        img_max2=max(img_max2,imgnow2_1);
        iplane2_2=reader2.getIndex(k-1,1,i-1)+1;
        imgnow2_2=bfGetPlane(reader2,iplane2_2);
        img_max2_2=max(img_max2_2,imgnow2_2);
    end
        
    cattempimg2=cat(3,imadjust(img_max2),imadjust(img_max2_2),zeros(size(img_max2)));
    cattempimg2_double=im2double(cattempimg2);
    writeVideo(V,cattempimg2_double)
   
end
close(V);


%%

% Problem 3. 
% Continue with the data from part 2
% 
% 1. Use your MATLAB code from Problem 2, Part 2  to generate a maximum
% intensity projection image of the first channel of the first time point
% of movie 1. 

reader1=bfGetReader('nfkb_movie1.tif'); 
z=reader1.getSizeZ;
iplane=reader1.getIndex(0,0,0)+1;
imgmax=bfGetPlane(reader1,iplane);
for i=1:z
    iplane=reader1.getIndex(i-1,0,0)+1;
    imgnow=bfGetPlane(reader1,iplane);
    imgmax=max(imgmax,imgnow);
end
img1=imgmax;
figure(3);
imshow(img1,[]);

% 2. Write a function which performs smoothing and background subtraction
% on an image and apply it to the image from (1). Any necessary parameters
% (e.g. smoothing radius) should be inputs to the function. Choose them
% appropriately when calling the function.

img2 = BackgroundSub(img1,2,10,100);
figure(4);
imshow(img2,[]);

% 3. Write  a function which automatically determines a threshold  and
% thresholds an image to make a binary mask. Apply this to your output
% image from 2. 

img3=mask(img2);
figure(5);
imshow(img3,[]);

% 4. Write a function that "cleans up" this binary mask - i.e. no small
% dots, or holes in nuclei. It should line up as closely as possible with
% what you perceive to be the nuclei in your image. 

img4=cleanup(img3);
figure(6);
imshow(img4,[]);

% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 

[number,meanarea,meanintensity]=count(img2,img4);
number
meanarea
meanintensity

% 6. Apply your function from (2) to make a smoothed, background subtracted
% image from channel 2 that corresponds to the image we have been using
% from channel 1 (that is the max intensity projection from the same time point). Apply your
% function from 5 to get the mean intensity of the cells in this channel. 
%%

reader1=bfGetReader('nfkb_movie1.tif');
iplane=reader1.getIndex(0,1,0)+1;
img_max1=bfGetPlane(reader1,iplane);
z=reader1.getSizeZ;
for k = 2:z
        iplane=reader1.getIndex(k-1,1,0)+1;
        tempimg1=bfGetPlane(reader1,iplane);
        img_max1=max(img_max1,tempimg1);
end
bsimg=BackgroundSub(img_max1,4,2,100);
m=mask(bsimg);
cmask=cleanup(m); 
[number,meanarea,meanintensity]=count(bsimg,cmask);
meanintensity

% Problem 4. 

% 1. Write a loop that calls your functions from Problem 3 to produce binary masks
% for every time point in the two movies. Save a movie of the binary masks.



% 2. Use a loop to call your function from problem 3, part 5 on each one of
% these masks and the corresponding images and 
% get the number of cells and the mean intensities in both
% channels as a function of time. Make plots of these with time on the
% x-axis and either number of cells or intensity on the y-axis. 

