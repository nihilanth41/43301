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
a(1,1) = sin(oat_radians(1))*cos(oat_radians(2)); % soca = T(1,3);
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
expr_n1 = ( (-Py*sqrt((Px^2)+(Py^2)-(d2^2)))-(d2*Px) ); % +-
expr_d1 = ( (-Px*sqrt((Px^2)+(Py^2)-(d2^2)))+(d2*Py) ); % +-
theta_1 = atan2(expr_n1,expr_d1);

% theta_2 -> depends on 
% theta_3:
%gamma_3 = 2*a2*sqrt((a3^2)+(d4^2)); % Page 6 L21
gamma_sq_sub_r_sq = sqrt( ((4*(a2^2)*(a3^2))+(4*(a2^2)*(d4^2))) - ((Px^2)+(Py^2)+(Pz^2)-(a2^2)-(a3^2)-(d2^2)-(d4^2))^2 );
expr_n3 = (2*a2*d4*((Px^2)+(Py^2)+(Pz^2)-(a2^2)-(a3^2)-(d2^2)-(d4^2))-(2*a2*a3*gamma_sq_sub_r_sq));
expr_d3 = ((2*a2*d4*gamma_sq_sub_r_sq)+(2*a2*a3*((Px^2)+(Py^2)+(Pz^2)-(a2^2)-(a3^2)-(d2^2)-(d4^2))));
theta_3 = atan2(expr_n3,expr_d3);

% theta_2:
expr_n2 = -((Pz*(a2+a3*cos(theta_3)+d4*sin(theta_3)))+(((d4*cos(theta_3))-(a3*sin(theta_3)))*sqrt((Px^2)+(Py^2)-(d2^2))));
expr_d2 = (Pz*((d4*cos(theta_3))-(a3*sin(theta_3)))) - ((a2+(a3*cos(theta_3))+(d4*sin(theta_3)))*sqrt((Px^2)+(Py^2)-(d2^2)));
theta_2 = atan2(expr_n2,expr_d2);

% Transformation from base to joint 3 T_03
% T_03 = [ cos(theta_1)*cos(theta_2+theta_3) -sin(theta_1) cos(theta_1)*sin(theta_2+theta_3) a2*cos(theta_1)*cos(theta_2)+a3*cos(theta_1)*cos(theta_2+theta_3)-d2*sin(theta_1);
%          sin(theta_1)*cos(theta_2+theta_3) cos(theta_1) sin(theta_1)*sin(theta_2+theta_3) a2*sin(theta_1)*cos(theta_2)+a3*sin(theta_1)*cos(theta_2+theta_3)+d2*cos(theta_1);
%          -sin(theta_2+theta_3) 0 cos(theta_2+theta_3) -a2*sin(theta_2)-a3*sin(theta_2+theta_3);
%          0 0 0 1 ];

R_03 = [ cos(theta_1)*cos(theta_2+theta_3) -sin(theta_1) cos(theta_1)*sin(theta_2+theta_3) 
         sin(theta_1)*cos(theta_2+theta_3) cos(theta_1)  sin(theta_1)*sin(theta_2+theta_3)
         -sin(theta_2+theta_3)             0             cos(theta_2+theta_3)];

% Construct T_06 to find T_36 to solve for theta_{4,5,6}
O = oat_radians(1);
A = oat_radians(2);
T = oat_radians(3);
R_06 = [ -sin(O)*sin(A)*cos(T)+cos(O)*sin(T) sin(O)*sin(A)*sin(T)+cos(O)*cos(T)  sin(O)*cos(A);
         cos(O)*sin(A)*cos(T)+sin(O)*sin(T)  -cos(O)*sin(A)*sin(T)+sin(O)*cos(T) -cos(O)*cos(A);
         -cos(A)*cos(T)                      cos(A)*sin(T)                       -sin(A) ];

% T_06 = R_06; 
% T_06(:,4) = XYZ';
% T_06(4,:) = [ 0 0 0 1 ];
% disp(T_06);

%T_36 = inv(T_03)*T_06;
R_36 = R_03' * R_06;
theta_6 = atan2(R_36(3,2), -R_36(3,1));

theta_4 = atan2(R_36(2,3), R_36(1,3));
%theta_5 = acos(T_36(3,3)); % Inverse cos() 
%theta_5 = atan2( (R_36(3,2))/sin(theta_6), R_36(3,3 )); % Different

theta_5 = atan2(R_36(1,3)/cos(theta_4),R_36(3,3));% option.

% Convert to degrees & return.
joint_angles(1,1) = theta_1;
joint_angles(1,2) = theta_2;
joint_angles(1,3) = theta_3;
joint_angles(1,4) = theta_4;
joint_angles(1,5) = theta_5;
joint_angles(1,6) = theta_6;
joint_angles = joint_angles / (pi/180);
disp(joint_angles);
end

