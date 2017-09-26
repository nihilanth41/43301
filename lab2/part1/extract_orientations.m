% Extract position (u,v) and orientation (theta) for each object in the image.
% Input image `filename` 
% Output matrix nx3, n = number of objects

% read image specified by 'filename'
img = imread('left01.ppm');

I = rgb2gray(img);
% find grey threshold & binarize image 
level = graythresh(I);
bin = imbinarize(I,level);

% which algorithm?
BW = edge(bin, 'canny');

% assign labels for objects
L = bwlabel(BW);

% Orientation is angle w.r.t. x-axis
stats = regionprops(L, 'Centroid', 'Orientation');
