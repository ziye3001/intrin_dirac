function a = face_area(V,F)
v1= V(F(:,2),:)-V(F(:,1),:);
v2= V(F(:,3),:)-V(F(:,2),:);
crossproduct = cross(v1,v2,2);
a=sqrt(dot(crossproduct,crossproduct,2))/2.0;
end