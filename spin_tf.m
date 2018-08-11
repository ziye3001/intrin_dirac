%% Apply the spin transformation w.r.t a spinor field
% Input: surface data structure contructed by build_surface.m
% Output: f_v: The 3D coordinate of the transformed vertices.
%         phi: The spinor field (satifying the Dirac equation).

function f_v = spin_tf (surf_data, phi)


phi= real(phi);

phi= phi / sqrt(sum(phi.^2,1)) * sqrt(size(surf_data.F,1));


phi = cat(3,phi(1:4:end,:), phi(2:4:end,:), phi( 3:4:end,:), phi(4:4:end,:));
hyperedges = cat(3, surf_data.hyperedges(:,1) , surf_data.hyperedges(:,2), surf_data.hyperedges(:,3), surf_data.hyperedges(:,4));

face_id_indices = surf_data.face_he_face(:,1);



%f_edge  =   conj(phi) * hyperedge * phi
f_edge = quat_prod(quat_prod(quat_conj(phi(face_id_indices,:,:)),hyperedges),phi(surf_data.face_he_face(:,3),:,:));





%switch the halfedges to one-directional edges, to make the computation
%faster
edges=unique(sort(surf_data.halfedges,2),'rows');
[~,edges_halfedges]=ismember(edges,surf_data.halfedges,'rows');


index_x = (1:size(edges,1))';
index_y_minus =  edges(:,1);
index_y_plus =  edges(:,2);


bx=f_edge(edges_halfedges,:,2);
by=f_edge(edges_halfedges,:,3);
bz=f_edge(edges_halfedges,:,4);

matrix = sparse(index_x,index_y_minus, -1, size(edges,1),size(surf_data.V,1)) ...
    + sparse(index_x,index_y_plus, 1, size(edges,1),size(surf_data.V,1)) ;

matrix= matrix(:,1:end-1);



%fix the last vertex
f_v= [matrix \ bx, matrix \ by, matrix \ bz];
f_v =[f_v; 0 0 0];

end