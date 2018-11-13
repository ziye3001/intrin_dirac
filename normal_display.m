function normal_display(V,F)
n=normalizerow(normals(V,F));
bc = barycenter(V,F);
quiver3(bc(:,1),bc(:,2),bc(:,3),n(:,1),n(:,2),n(:,3))
end

