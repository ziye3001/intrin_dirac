%build necessary structures, e.g., hyperedges, normals...
function surf_data = build_surface(V,F)
surf_data.F= F;
surf_data.V= V;



%use the functions from gltoolbox, create the list the neibouring face
%through the corresponding halfedges
[neibour_face,~] = triangle_triangle_adjacency(F);

%The following works for the mesh with boundary
list_num_boundaries = sum(neibour_face==-1,2);
%list_no_boundary = find(list_num_boundaries == 0);
%list_one_boundary = find(list_num_boundaries == 1);
list_two_boundaries = find(list_num_boundaries == 2);

if size(list_two_boundaries,1) ~= 0 
warning('There are faces with more than one boundary, which can give bad results');
end

neibour_face = neibour_face(:);

%list of faces -- halfedges -- neibouring faces
surf_data.face_he_face = [repmat([1:size(F,1)]',3,1), (1:size(neibour_face,1))', neibour_face];

surf_data.list_one_boundary =  surf_data.face_he_face ( neibour_face == -1 ,1:2);
surf_data.face_he_face = surf_data.face_he_face ( neibour_face ~= -1 ,:);





%the list of halfedges
surf_data.halfedges = [F(:,[2 3]);F(:,[3 1]);F(:,[1 2])];
surf_data.halfedges = surf_data.halfedges(surf_data.face_he_face(:,2),:);

%create the normal list of the faces
normal_face=normalizerow(normals(V,F));



halfedges_coordinate = -V(F(:,[2 3 1]),:)+V(F(:,[3 1 2]),:);
halfedges_coordinate = halfedges_coordinate( surf_data.face_he_face(:,2),:);

%compute the mean curvature on the edges
normals_right = normal_face(surf_data.face_he_face(:,3),:);

normal_face_extend= normal_face(surf_data.face_he_face(:,1),:);
edge_norm_squre = dot(halfedges_coordinate,halfedges_coordinate,2);

meancurvature_edge= dot(normal_face_extend, ...
    normal_face_extend - normals_right-2 * bsxfun(@rdivide,halfedges_coordinate,edge_norm_squre),2)...
    ./(dot(cross(normal_face_extend,normals_right,2),bsxfun(@rdivide,halfedges_coordinate,edge_norm_squre),2) ...
    );



plane_index=find(abs(dot(cross(normal_face_extend,normals_right,2),bsxfun(@rdivide,halfedges_coordinate,edge_norm_squre),2) ...
    ) < (1e-5)* min(edge_norm_squre) );
meancurvature_edge(plane_index) = 0;


%construct the hyperedges
surf_data.hyperedges = [meancurvature_edge , halfedges_coordinate ];

%construct the mean curvature integrated on the faces
surf_data.face_curvature = zeros(3*size(F,1),1);
surf_data.face_curvature(surf_data.face_he_face(:,2),:) = meancurvature_edge;


surf_data.face_curvature=sum(reshape(surf_data.face_curvature, size(F,1),3),2);

surf_data.willmore_energy = sum(surf_data.face_curvature.^2 ./ face_area(V,F),1)/4;
end