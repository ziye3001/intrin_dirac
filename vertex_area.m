function vertex_area_list=vertex_area(V,F)
face_area_list = face_area(V,F);

index_x = F(:);
index_y = repmat((1:size(F,1))',3,1);

adj_m = sparse(index_x,index_y,1,size(V,1),size(F,1));
vertex_area_list = adj_m * face_area_list /3; 
end
