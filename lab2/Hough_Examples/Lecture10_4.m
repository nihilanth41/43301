close all
I  = imread('circuit.tif');
rotI = imrotate(I,33,'crop');
BW = edge(rotI,'canny');
figure, subplot(2,3,1);
imshow(I)
subplot(2,3,2);
[H,T,R] = hough(BW);
imshow(BW)
subplot(2,3,[4 5 6]);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','green');

subplot(2,3,3);
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
  xy = [lines(k).point1; lines(k).point2];
  plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

  % plot beginnings and ends of lines
  plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
  plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

  % determine the endpoints of the longest line segment 
  len = norm(lines(k).point1 - lines(k).point2);
  if ( len > max_len)
    max_len = len;
    xy_long = xy;
  end
end

% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

