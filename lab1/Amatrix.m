% Assign z-values 
z_offset_mm = [ 0 38.1 76.2 114.3 152.4 ];
X_1(3,:) = z_offset_mm(1);
X_2(3,:) = z_offset_mm(2);
X_3(3,:) = z_offset_mm(3);
X_4(3,:) = z_offset_mm(4);
X_5(3,:) = z_offset_mm(5);

% construct matricies for constructing A matrix - instric & extrinsic
XYZ = [ X_1 X_2 X_3 X_4 X_5 ];
UV = [ x_1 x_2 x_3 x_4 x_5 ];

A=[];
for i = 1:length(XYZ) % foreach each column
    
A=[ A; 
    [ XYZ(1,i) XYZ(2,i) XYZ(3,i) 1 0 0 0 0 -UV(1,i)*XYZ(1,i) -UV(1,i)*XYZ(2,i) -UV(1,i)*XYZ(3,i) -UV(1,i); 
      0 0 0 0 XYZ(1,i) XYZ(2,i) XYZ(3,i) 1 -UV(2,i)*XYZ(1,i) -UV(2,i)*XYZ(2,i) -UV(2,i)*XYZ(3,i) -UV(2,i)
    ] 
   ];

end

[U,D,V] = svd(A); 
q = V(:, end);
P = reshape(q, [4,3])'; % ' == transpose()
