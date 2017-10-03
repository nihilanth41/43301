% Get P_left, P_right calibration matrix
load('projection.mat');
% Get [u,v], theta for objects stats_left, stats_right
load('stats.mat');

% size(A) = 4,3
% M = [x;y;z] 3x1
% b = 4x1
centroids_right = cat(1, stats_right.Centroid);
centroids_left = cat(1, stats_left.Centroid);

% TODO: iterate over these [u,v] 
% For now just use the first object 
u_r = centroids_right(1,1);
v_r = centroids_right(1,2);
u_l = centroids_left(1,1);
v_l = centroids_left(1,2);

%M = reconstruct3d(u_l,v_l,u_r,v_r,P_left,P_right);

load('calib_left.mat', 'UV', 'XYZ');
UV_left = UV;
XYZ_left = XYZ;

load('calib_right.mat', 'UV', 'XYZ');
UV_right = UV;
XYZ_right = XYZ;

% for each [u,v]_{left,right} compare result M to XYZ
for i = 1:192
    M = reconstruct3d(UV_left(1,i),UV_left(2,i),UV_right(1,i),UV_right(2,i),P_left,P_right);
    E(:,i) = XYZ(:,i) - M;
end
    
