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

% Translations in 'mm' wrt new frame after rotation i.e. the same as camera 
% i.e. move camera 0,0 to robot 0,0 
tx=305;
ty=358;
tz=325-13;
H_rw = [ 0 -1 0 tx; 
         1 0 0 ty;
         0 0 1 tz; 
         0 0 0 1 ];



    
