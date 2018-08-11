% Return the vertex-to-face adjacent matrix such that the non-zero entries would 
% all be 1. 

function D = adj_vf(surf_data,type)

V=surf_data.V;
F=surf_data.F;
% computes the averaging vertex-to-face matrix
if nargin == 1 || strcmp(type,'quaternion') == 1 
index_x=repmat((repmat((1:size(F,1))',3,1)-1)*4,4,1)+reshape(repmat(1:4,[3*size(F,1),1]),[],1);

index_y= repmat((F(:)-1)*4,4,1)+ reshape(repmat(1:4,[3*size(F,1),1]),[],1);
D=sparse(index_x,index_y,1,4*size(F,1),4*size(V,1));

elseif strcmp(type, 'complex') == 1
index_x=repmat((repmat((1:size(F,1))',3,1)-1)*2,2,1)+reshape(repmat(1:2,[3*size(F,1),1]),[],1);
index_y= repmat((F(:)-1)*2,2,1)+ reshape(repmat(1:2,[3*size(F,1),1]),[],1);
D=sparse(index_x,index_y,1,2*size(F,1),2*size(V,1));

elseif strcmp(type, 'real') == 1 
index_x =repmat((1:size(F,1))',1,3);
index_y = F;
D=sparse(index_x,index_y,1,size(F,1),size(V,1));
    
    
end
end