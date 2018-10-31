% Input: a shape  + the mean curvature half-density rho, 
% Output: A shape with h = h_old + rho 

function [V_new,eigen_f]=curvature_painting(V,F,mchd)

surf1 = build_surface(V,F);


dirac_matrix = intrin_dirac(surf1);


face_area1 = face_area(V,F);

rho = mchd .* sqrt(face_area1);

dirac_matrix = dirac_matrix - spdiags(reshape(repmat(rho,1,4)',[],1),0,4*size(F,1),4*size(F,1));

% vertex to face adjacent matrix
adj_matrix = adj_vf(surf1);

[eigen_f,eigen_v]=dirac_singular(surf1, dirac_matrix,adj_matrix, 1);

V_new = spin_tf(surf1,adj_matrix*eigen_f(:,1));


eigen_f = adj_matrix * eigen_f(:,1);
end


