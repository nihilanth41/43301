function [ T ] = base2end( theta )
%BASE2END Determines total transformation between base and end-effector.
% INPUT: joint angles theta_1 .. theta_n  
% OUTPUT: Transformation matrix T, 0A1*1A2*..*
% Lecture 21 Page 2
theta = theta * pi/180;
    % Option 3, lengths in mm
    a2 = 203.2; % mm - 8"
    a3 = 0; % Our robots a3 = 0 from lect21.
    d2 = 125.4125 %mm - 4.9375" = (2+(7/8)) + (2+(1/16))" 
    d3 = 0;     % Option 3
    d4 = 203.2; % mm - 8"
    d6 = 55.9308; % mm - 2.202"
    A1 = [ cos(theta(1)) 0 -sin(theta(1)) 0;
           sin(theta(1)) 0 cos(theta(1)) 0;
           0 -1 0 0;= 0;     % Option 3
    d4 = 203.2; % mm - 8"
    d6 = 55.9308; % mm - 2.202"
    A1 = [ cos(theta(1)) 0 -sin(theta(1)) 0;
           sin(theta(1)) 0 cos(theta(1)) 0;
           0 -1 0 0;
           0 0 0 1; ]; 
    A2 = [ cos(theta(2)) -sin(theta(2)) 0 a2*cos(theta(2));
           sin(theta(2)) cos(theta(2)) 0 a2*sin(theta(2));
           0 0 1 d2;
           0 0 0 1; ];
    A3 = [ cos(theta(3)) 0 sin(theta(3)) a3*cos(theta(3));
           sin(theta(3)) 0 -cos(theta(3)) a3*sin(theta(3));
           0 1 0 0;
           0 0 0 1; ];
    A4 = [ cos(theta(4)) 0 -sin(theta(4)) 0;
           sin(theta(4)) 0 cos(theta(4)) 0;
           0 -1 0 d4;
           0 0 0 1; ];
    A5 = [ cos(theta(5)) 0 sin(theta(5)) 0;
           sin(theta(5)) 0 -cos(theta(5)) 0;
           0 1 0 0;
           0 0 0 1; ];
    A6 = [ cos(theta(6)) -sin(theta(6)) 0 0;
           sin(theta(6)) cos(theta(6)) 0 0;
           0 0 1 d6;
           0 0 0 1 ];
    T = A1*A2*A3*A4*A5*A6;

end

