%% Return a vector of cos theta/2, where theta is the dihedral angle

function ret = half_cos(surf_data)
normal_face=normalizerow(normals(surf_data.V,surf_data.F));

normals_right = normal_face(surf_data.face_he_face(:,3),:);

normal_face_extend= normal_face(surf_data.face_he_face(:,1),:);

ret = sqrt( (dot(normals_right,normal_face_extend,2) +1)/2);

end
