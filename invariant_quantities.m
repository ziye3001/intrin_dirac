function [eigen_f,eigen_v,n,v1,v2]= invariant_quantities(eigen_f,eigen_v,nv)



if size(find(eigen_v <0),1) >0
    eigen_f1 = eigen_f(:,find(eigen_v >0));
    eigen_f2 = eigen_f(:,find(eigen_v <0));
    eigen_v1 = eigen_v(find(eigen_v >0));
    eigen_v2 = eigen_v(find(eigen_v <0));
    
    [~,order1] = sort(eigen_v1);
    [~,order2] = sort(abs(eigen_v2));
    
    eigen_f(:,1:2:end) = eigen_f1(:,order1);
    eigen_f(:,2:2:end) = eigen_f2(:,order2);
    eigen_v(1:2:end) = eigen_v1(order1);
    eigen_v(2:2:end) = eigen_v2(order2);
else
    [~,order1] = sort(eigen_v);
    eigen_f = eigen_f(:,order1);
    eigen_v = eigen_v(order1);
    
end


n = sqrt(eigen_f(1:4:end,:).^2 + eigen_f(2:4:end,:).^2 + eigen_f(3:4:end,:).^2 + eigen_f(4:4:end,:).^2);

v1=eigen_f(1:4:end,:)./n;

nv =repmat(permute(nv,[1 3 2]), 1, size(eigen_f,2));

axis = cat(3,eigen_f(2:4:end,:),eigen_f(3:4:end,:),eigen_f(4:4:end,:));
axis = axis ./ repmat( sqrt(axis(:,:,1).^2 + axis(:,:,2).^2 +axis(:,:,3).^2) , 1,1, 3);

v2=dot(axis,  nv ,3);

end
