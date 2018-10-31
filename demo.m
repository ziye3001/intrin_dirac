%% Compute Dirac eigenfunctions 
clc;
clear;

num = 20;
[V,F] = load_mesh('data/spot_triangulated.obj');

surf1 = build_surface(V,F);
surf1.hyperedges = surf1.hyperedges .* half_cos(surf1);

dirac_matrix = intrin_dirac(surf1);
adj_matrix = adj_vf_cov(surf1);

[eigen_f,eigen_v]=dirac_eigen(surf1,dirac_matrix,adj_matrix,num);

%% Create Dirac immersions
clc;
clear;

num = 3;
[V,F] = load_mesh('data/spot_triangulated.obj');
v_new = dirac_immersion(V,F,3);

subplot(1,num+1,1)
shape_display(V,F)
for i= 1:num
    subplot(1,num+1,i+1)
    shape_display(v_new{i},F)
end

%% Transfer the mean curvature half-density from V1 to V2
clear;
clc;

[V1,F1] = load_mesh('data/spot_sphere.obj');
[V2,F2] = load_mesh('data/spot_triangulated.obj');
v_new = curvature_transfer(V1,V2,F1);
shape_display(v_new,F1)
%% Transfer the mean-curvature from V1 to V2 with several steps
clear;
clc;

iter = 15;
steplength = 0.3;

[V1,F1] = load_mesh('data/spot_sphere.obj');
[V2,F2] = load_mesh('data/spot_triangulated.obj');

v_new = V1; 
for i=1:iter
    i
    v_new = curvature_transfer_iter(v_new,V2,F1,steplength);
end

shape_display(v_new,F1)

%% Conformal faring via Willmore flow
clc;
clear;

steplength = 0.3;
iter = 10;
[V,F] = load_mesh('data/spot_triangulated.obj');

v_new = V; 
for i=1:iter
    i
    v_new = willmore_fairing(v_new,F,steplength);
end

shape_display(v_new,F)

