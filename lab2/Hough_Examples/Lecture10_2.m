I = imread('circuit.tif');
BW = edge(I,'canny');
figure, imshow(I)
figure, imshow(BW)
[H,T,R] = hough(BW,'RhoResolution',0.5,'ThetaResolution',0.5);
figure, subplot(2,1,1);
imshow(I);
subplot(2,1,2);
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,'InitialMagnification','fit');
axis on, axis normal, hold on;