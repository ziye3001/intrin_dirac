function res = quat_prod(p,q)

if (size(p,3) == 4)
    pr=p(:,:,1);
    pi=p(:,:,2);
    pj=p(:,:,3);
    pk=p(:,:,4);
    
    qr=q(:,:,1);
    qi=q(:,:,2);
    qj=q(:,:,3);
    qk=q(:,:,4);
    
    res_r=pr.*qr-pi.*qi-pj.*qj-pk.*qk;
    res_i=pr.*qi+pi.*qr+pj.*qk-pk.*qj;
    res_j=pr.*qj-pi.*qk+pj.*qr+pk.*qi;
    res_k=pr.*qk+pi.*qj-pj.*qi+pk.*qr;
    
    res=cat(3,res_r,res_i,res_j,res_k);
        
else 
    pr=p(1:4:end,:);
    pi=p(2:4:end,:);
    pj=p(3:4:end,:);
    pk=p(4:4:end,:);
    
    qr=q(1:4:end,:);
    qi=q(2:4:end,:);
    qj=q(3:4:end,:);
    qk=q(4:4:end,:);
    
    res_r=pr.*qr-pi.*qi-pj.*qj-pk.*qk;
    res_i=pr.*qi+pi.*qr+pj.*qk-pk.*qj;
    res_j=pr.*qj-pi.*qk+pj.*qr+pk.*qi;
    res_k=pr.*qk+pi.*qj-pj.*qi+pk.*qr;
    
    res = zeros(size(p,1),size(p,2));
    res(1:4:end,:) = res_r;
    res(2:4:end,:) = res_i;
    res(3:4:end,:) = res_j;
    res(4:4:end,:) = res_k;

end

