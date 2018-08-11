function res = quat_conj(p)

if (size(p,3) == 4)
    pr=p(:,:,1);
    pi=p(:,:,2);
    pj=p(:,:,3);
    pk=p(:,:,4);
    
    res = cat(3 , pr, -pi, -pj, -pk);
    
else
    
    pr = p(1:4:end,:);
    pi = p(2:4:end,:);
    pj = p(3:4:end,:);
    pk = p(4:4:end,:);
    
    res = zeros(size(p,1),size(p,2));
    res(1:4:end,:) = pr;
    res(2:4:end,:) = -pi;
    res(3:4:end,:) = -pj;
    res(4:4:end,:) = -pk;
    

end
