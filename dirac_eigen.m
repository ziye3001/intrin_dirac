%The Dirac singular value problem, for the problems which require multiple eigenfunctions.


function [eigen_f,eigen_v]=dirac_eigen(surf_data,dirac_matrix,adj_matrix,eigen_num)


V= surf_data.V;
F= surf_data.F;


%inverse of the mass matrix in a quaternionic way:
%diag(1/m1,1/m1,1/m1,1/m1,... ,1/m_n,1/m_n,1/m_n,1/m_n

mass_inv = spdiags(reshape(repmat(face_area(V,F).^(-1),1,4)',[],1),0,4*size(F,1),4*size(F,1));

m1=0.5 * adj_matrix'*dirac_matrix'*mass_inv*dirac_matrix*adj_matrix;
m2= adj_matrix'*dirac_matrix*adj_matrix;
%m1=0.5 * adj_matrix'*dirac_matrix'*dirac_matrix*adj_matrix;
%m2=adj_matrix'*(mass_sq)*dirac_matrix*(mass_sq)*adj_matrix;


%(optional),due to some numercial errors the matrix might be non-symmetric
m1 = 0.5 *( m1 + m1');
m2=  0.5 *( m2  +m2');

[eigen_f,eigen_v] = eigs(m1,m2 ,4* eigen_num ,'sm');

%sort the eigenvectors/functions by the absoulute value of eigenvalues
eigen_v=diag(eigen_v);
[~,sort_m] = sort(abs(eigen_v));
eigen_f = eigen_f(:,sort_m);
eigen_v = eigen_v(sort_m);

%remove the redundant informations
eigen_v=eigen_v(1:4:end,:);
eigen_f=eigen_f(:,1:4:end);
end