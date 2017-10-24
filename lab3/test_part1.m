%joint_angles = [ 30 30 30 30 30 30 ];
joint_angles = [ -150, -142, -14.6, 30, 90, 53]; 
T = base2end(joint_angles);
[XYZ,OAT] = get_oat(T);
% find OAT from xyz 