%The vertex-to-face adjacent matrix, covriant version.

function D = adj_vf_cov(surf_data)

V = surf_data.V;
F=  surf_data.F;

index_x = repmat( bsxfun(@plus,( (1:size(F,1))'-1) *4 ,(1:4)),3,4);
index_y = bsxfun(@plus, (F(:)-1)*4 ,(1:4));
index_y = index_y(:,[1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4]);

nf = normalizerow(normals(V,F));
nv = normalizerow(per_vertex_normals(V,F));

nf = nf(repmat((1:size(F,1))',3,1),:);
nv = nv(F(:),:);

axis = cross(nf,nv,2);
real_part = (dot(nf,nv,2) + 1);
% p^(-1) * nv *p = nf 

p = cat(3,real_part,-axis(:,1),-axis(:,2),-axis(:,3));

%sum(quat_prod_tri(quat_inv(p),vec_to_quat(nf),p) - vec_to_quat(nv),1)
p= p ./  repmat(sqrt(p(:,:,1).^2 + p(:,:,2).^2 + p(:,:,3).^2 + p(:,:,4).^2),1,1,4);
p = permute(p,[1 3 2]);

Q = [ ...
    1 0 0 0;0  1  0 0;0 0  1  0;0  0 0  1; ...
    0 -1 0 0;1  0  0 0;0 0  0 1;0  0 -1  0; ...
    0 0 -1 0;0  0  0 -1;1 0  0  0;0 1 0  0; ...
    0 0 0 -1;0  0 1 0;0 -1  0  0;1  0 0  0]';

D= sparse(index_x,index_y,p*Q,4*size(F,1),4*size(V,1));

%nfq = cat(3,zeros(size(nf,1),1),nf(:,1),nf(:,2),nf(:,3));
%nvq = cat(3,zeros(size(nv,1),1),nv(:,1),nv(:,2),nv(:,3));


end

