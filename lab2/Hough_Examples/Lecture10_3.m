I = imread('circuit.tif');
BW = edge(I,'canny');
figure, imshow(I)
figure, imshow(BW)
I  = imread('circuit.tif');
BW = edge(imrotate(I,50,'crop'),'canny');
[H,T,R] = hough(BW);
P  = houghpeaks(H,2);
figure, subplot(2,1,1);
imshow(I);
subplot(2,1,2);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','green');


