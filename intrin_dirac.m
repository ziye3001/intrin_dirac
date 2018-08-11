%% Build the intrinic Dirac operator matrix

function D = intrin_dirac(surf_data)
index_x= repmat( bsxfun(@plus,(surf_data.face_he_face(:,1)-1)*4,(1:4)),1,4);


index_y_pre= bsxfun(@plus, (surf_data.face_he_face(:,3)-1)*4, (1:4)) ;
index_y= index_y_pre(:,[1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4]);

Q = [ ...
    1 0 0 0;0  1  0 0;0 0  1  0;0  0 0  1; ...
    0 -1 0 0;1  0  0 0;0 0  0 1;0  0 -1  0; ...
    0 0 -1 0;0  0  0 -1;1 0  0  0;0 1 0  0; ...
    0 0 0 -1;0  0 1 0;0 -1  0  0;1  0 0  0]';
D= sparse(index_x,index_y,surf_data.hyperedges*Q,4*size(surf_data.F,1),4*size(surf_data.F,1));
end