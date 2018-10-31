function mchd = half_density(surfa)
mchd = surfa.face_curvature ./ sqrt(face_area(surfa.V,surfa.F));

end
