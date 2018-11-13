%% Reduce the Willmore Energy of the shape via the conformal Willmore flow [Crane et al, 2013]
% Input: V: |V| * 3 vertices list.
%        F: |F| * 3 faces list.
%        steplength: usually < 0.5. 
% Output: V_new: The 3D coordinate of the transformed vertices.
%         eigen_f: The corresponding spinor field.

function [V_new,eigen_f]=willmore_fairing( V,F, steplength)

surf1 = build_surface(V,F);

dirac_matrix = extrin_dirac(surf1);

face_area1 = face_area(V,F);

rho = steplength*surf1.face_curvature;
% project to some space so that the equation has a solution
rho =  ( rho - sum(rho,1)/sum(face_area1,1) * face_area1);

dirac_matrix = dirac_matrix +  spdiags(reshape(repmat(rho,1,4)',[],1),0,4*size(F,1),4*size(F,1));
% vertex to face adjacent matrix
%adj_matrix = vertex_to_face_rot(F,V1);
adj_matrix=adj_vf(surf1);

[eigen_f,~]=dirac_singular(surf1,dirac_matrix , adj_matrix, 1);

eigen_f = dirac_eigen_alignment(eigen_f, vertex_area(V,F));
V_new = spin_tf(surf1,adj_matrix*eigen_f(:,1));

end

