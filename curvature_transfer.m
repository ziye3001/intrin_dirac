%Given two meshes with the same connectivity, F1 = F2,
%We compare the difference of the mean curvature half-density, and try to
%recover the 2nd mesh from 1st mesh
function [V_new,eigen_f]=curvature_transfer(V1, V2,F)

surf1 = build_surface(V1,F);
surf2 = build_surface(V2,F);


dirac_matrix = intrin_dirac(surf1);


face_area1 = face_area(V1,F);
face_area2 = face_area(V2,F);


rho =  surf2.face_curvature .* sqrt(face_area1) ./ sqrt(face_area2) ;

dirac_matrix = dirac_matrix - spdiags(reshape(repmat(rho,1,4)',[],1),0,4*size(F,1),4*size(F,1));

% vertex to face adjacent matrix
adj_matrix = adj_vf(surf1);

[eigen_f,eigen_v]=dirac_singular(surf1, dirac_matrix,adj_matrix, 1);

V_new = spin_tf(surf1,adj_matrix*eigen_f(:,1));


eigen_f = adj_matrix * eigen_f(:,1);
end

