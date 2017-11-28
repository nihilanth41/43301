function [ joint_angles ] = inverse_k( XYZ, OAT )
%INVERSE_K Summary of this function goes here
%   Detailed explanation goes here
% Given XYZ, OAT of end effector = 0P6    
a2 = 203.2; % mm - 8"
a3 = 0; % Our robots a3 = 0 from lect21.
d2 = 125.4125; %mm - 4.9375" = (2+(7/8)) + (2+(1/16))" 
d3 = 0;     % Option 3
d4 = 203.2; % mm - 8"
d6 = 55.9308; % mm - 2.202"
gripper_len = 130; %mm -13cm
link_length = d6; %d6 + gripper?

% P_06 -> 6 wrt 0 == Given XYZ (of end effector)
P_06 = XYZ;
oat_radians = OAT * pi/180;
a(1,1) = sin(oat_radians(1))*cos(oat_radians(2)) % soca = T(1,3);
a(1,2) = -(cos(oat_radians(1)) * cos(oat_radians(2))); % coca = -(T(2,3));
a(1,3) = -(sin(oat_radians(2))); %sa = -(T(3,3));
% P_46 -> 6 wrt 4 
P_46 = link_length * a; 
% P_04 -> 4 wrt 0 -> xyz of joint 4 wrt base
P_04 = P_06 - P_46;

% Can solve for theta_1 now that we know P_04
% theta_1:
Px=P_04(1);
Py=P_04(2);
Pz=P_04(3);

% Consider only (-/-) case
expr_n1 = ( (Py*sqrt((Px^2)+(Py^2)-(d2^2)))-(d2*Px) ); % +-
expr_d1 = ( (Px*sqrt((Px^2)+(Py^2)-(d2^2)))+(d2*Py) ); % +-
theta_1 = atan2(expr_n1,expr_d1);

% theta_2 -> depends on 
% theta_3:
%gamma_3 = 2*a2*sqrt((a3^2)+(d4^2)); % Page 6 L21
gamma_sq_sub_r_sq = sqrt( ((4*(a2^2)*(a3^2))+(4*(a2^2)*(d4^2))) - ((Px^2)+(Py^2)+(Pz^2)-(a2^2)-(a3^2)-(d2^2)-(d4^2))^2 );
expr_n3 = (2*a2*d4*((Px^2)+(Py^2)+(Pz^2)-(a2^2)-(a3^2)-(d2^2)-(d4^2))-(2*a2*a3*gamma_sq_sub_r_sq));
expr_d3 = ((2*a2*d4*gamma_sq_sub_r_sq)+(2*a2*a3*((Px^2)+(Py^2)+(Pz^2)-(a2^2)-(a3^2)-(d2^2)-(d4^2))));
theta_3 = atan2(expr_n3,expr_d3);

% theta_2:
expr_n2 = -((Pz*(a2+(a3*cos(theta_3))+(d4*sin(theta_3))))+(((d4*cos(theta_3))-(a3*sin(theta_3)))*sqrt((Px^2)+(Py^2)-(d2^2))));
expr_d2 = (Pz*((d4*cos(theta_3))-(a3*sin(theta_3)))) - ((a2+(a3*cos(theta_3))+(d4*sin(theta_3)))*sqrt((Px^2)+(Py^2)-(d2^2)));
theta_2 = atan(expr_n2/expr_d2);

joint_angles(1,1) = theta_1
joint_angles(1,2) = theta_2
joint_angles(1,3) = theta_3
joint_angles = joint_angles / (pi/180);
end

