function [ OAT ] = get_oat( T )
%GET_OAT Summary of this function goes here
%   Detailed explanation goes here
% Lecture 16 Page 2

% Solve for O
soca = T(1,3);
coca = -(T(2,3));
OAT(1) = atan2(soca,coca);

% Solve for T
cact = -(T(3,1));
cast = T(3,2);
OAT(3) =  atan2(cast,cact);

% Solve for A
ca = cact/cos(OAT(3)); 
sa = -(T(3,3));
OAT(2) = atan2(sa,ca);
%XYZ = [ T(1,4) T(2,4) T(3,4) ];

end

