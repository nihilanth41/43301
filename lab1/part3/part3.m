load("part1/calib_left.mat", "XYZ", "P");
% make 4xn
XYZ(4,:) = 1;
% [Uu; Vu; 1] = P*XYZ
% undistorted
uv_1 = P*XYZ

load("part2/left_calib_data.mat");
go_calib_optim

XYZ_2 = XYZ;
T = [ Tc_1 Tc_2 Tc_3 Tc_4 Tc_5 ];
R = [ Rc_1 Rc_2 Rc_3 Rc_4 Rc_5 ];
% Construct P matrix from KK, Tc_n, Rc_n
% Instrinsic, Translation, Rotation matricies
P_p2 = [ (fc(1)*R(1)+(cc(1)*R(3))) (fc(1)*T(1))+(cc(1)*T(3));
         (fc(2)*R(2)+(cc(2)*R(3))) (fc(2)*T(2))+(cc(2)*T(3));
          R(3) T(3) ];
        
uv_2 = P_p2*XYZ_2