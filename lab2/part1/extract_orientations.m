% Extract position (u,v) and orientation (theta) for each object in the image.
% Input image `filename` 
% Output matrix nx3, n = number of objects

% read image specified by 'filename'
img = imread('right02.ppm');

I = rgb2gray(img);

% find grey threshold & binarize image 
%level = graythresh(I);    
% IMPROVEMENT? => Use histogram to find gray threshold
level = 0.95;
bin = imbinarize(I,level);

% which algorithm?
%BW = edge(bin, 'Canny');
% IMPROVEMENT? => Use utso method to find thresholding 
threshold = 0.98;
[BW,threshold] = edge(bin, 'Canny', threshold);
% assign labels for objects
L = bwlabel(BW);

% Orientation is angle w.r.t. x-axis
stats = regionprops(L, 'Centroid', 'Orientation');

centroids = cat(1, stats.Centroid);
imshow(BW)
hold on 
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
