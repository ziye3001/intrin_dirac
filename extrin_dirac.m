%% Build the intrinic Dirac operator matrix

function D = extrin_dirac(surf_data)
%The intrinsic Dirac operator is a 4|F|*4|F| symmetric matrix.

in_dirac = intrin_dirac(surf_data);

diag_part =  spdiags(reshape(repmat(surf_data.face_curvature,1,4)',[],1),0,4*size(surf_data.F,1),4*size(surf_data.F,1));

D = in_dirac - diag_part + 1e-7* speye(4*size(surf_data.F,1));

end