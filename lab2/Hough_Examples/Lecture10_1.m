I = imread('REMOVER.jpg');
I=rgb2gray(I);
BW1 = edge(I,'prewitt');
BW2 = edge(I,'canny');
BW3 = edge(I,'sobel');
figure, subplot(2,2,1)
figure, imshow(I)
subplot(2,2,1)
 imshow(BW1)
 imshow(BW2)
 imshow(BW3)

