% Get P_left, P_right calibration matrix
% also UV_{left,right} and XYZ_{left,right}
load('projection.mat');
% Get [u,v], theta for objects stats_left, stats_right
load('stats.mat');

% Right and left should be the same 
XYZ = XYZ_left;

centroids_right = cat(1, stats_right.Centroid);
centroids_left = cat(1, stats_left.Centroid);

u_r = centroids_right(1,1);
v_r = centroids_right(1,2);
u_l = centroids_left(1,1);
v_l = centroids_left(1,2);

% for each [u,v]_{left,right} compare result M to XYZ
for i = 1:length(XYZ)
    M(:,i) = reconstruct3d(UV_left(1,i),UV_left(2,i),UV_right(1,i),UV_right(2,i),P_left,P_right);
    E(:,i) = XYZ(:,i) - M(:,i);
end

% At this point 'M' is our xyz position of the object(s) wrt the camera (i.e. world)

% Position object-robot = Homography(robot-world) * Position object-world
tx=0
ty=0;
tz=0;
% No rotation, so R = eye(3) 
% Might need to rotate 90 deg s.t. x,y axis of robot align with x,y axis of
% camera.
% See: Page 32 val_puma.pdf
% Specifies the positition of the robot with respect to the camera. 
% (Or is it the reverse?)
% Origin of robot frame is at (+x, +y, -z) relative to the origin of the camera
% frame.
% Graphically camera frame looks like this:
%   (0,0)----> y-axis(+)
%        |
%        |
%        x-axis(+)
%
%                        Robot(0,0) somewhere over here.
H_rw = [ 1 0 0 tx; 
         0 1 0 ty;
         0 0 1 tz; 
         0 0 0 1 ];



    
