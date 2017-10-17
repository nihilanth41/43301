joint_angles = [ 30 30 30 30 30 30 ];
T = base2end(joint_angles);
[XYZ,OAT] = get_oat(T);
% find OAT from xyz 