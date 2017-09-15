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