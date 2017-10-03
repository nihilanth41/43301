function [ M ] = reconstruct3d(u_l,v_l,u_r,v_r,P_left,P_right)
%RECONSTRUCT3D 
%   
% Lecture 8 Page 2
A = [ P_right(1,1:3)-(u_r*P_right(3,1:3));
      P_right(2,1:3)-(v_r*P_right(3,1:3));
      P_left(1,1:3)-(u_l*P_left(3,1:3));
      P_left(2,1:3)-(v_l*P_left(3,1:3)); ];
  
b = [ (u_r*P_right(3,4))-P_right(1,4);
      (v_r*P_right(3,4))-P_right(2,4);
      (u_l*P_left(3,4))-P_left(1,4);
      (v_l*P_left(3,4))-P_left(2,4); ];

 M = inv((A'*A))*A'*b

end

