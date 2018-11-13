%% Return the first several intrinsic Dirac immersions

function v_new = dirac_immersion( V,F , num)

surf1 = build_surface(V,F);
surf1.hyperedges = surf1.hyperedges .* half_cos(surf1);

dirac_matrix = intrin_dirac(surf1);
adj_matrix = adj_vf_cov(surf1);
%adj_matrix = adj_vf(surf1);

[eigen_f,eigen_v]=dirac_eigen(surf1,dirac_matrix,adj_matrix,2*num);

eigen_f = dirac_eigen_alignment(eigen_f, vertex_area(V,F));

for i= 1:num
    v_new{i} = spin_tf(surf1,adj_matrix*eigen_f(:,2*i-1));
end


end

