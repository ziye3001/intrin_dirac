% Align the Dirac eigenfunction introduced in [Liu et al, 2017]


function output= dirac_eigen_alignment(f, weights)

eigen_reform(:,:,1)= f(1:4:end, :);
eigen_reform(:,:,2)= f(2:4:end, :);
eigen_reform(:,:,3)= f(3:4:end, :);
eigen_reform(:,:,4)= f(4:4:end, :);

norm_sq = sum(eigen_reform.^2,3);
eigen_inv(:,:,1) = eigen_reform(:,:,1) ./ norm_sq ;
eigen_inv(:,:,2) = -eigen_reform(:,:,2) ./ norm_sq ;
eigen_inv(:,:,3) = -eigen_reform(:,:,3) ./ norm_sq ;
eigen_inv(:,:,4) = -eigen_reform(:,:,4) ./ norm_sq ;

if nargin == 2
    
eigen_inv = eigen_inv .* repmat(weights,1,size(f,2),4);
end

scale = sum(eigen_inv,1);
scale = scale ./ repmat(sqrt(scale(:,:,1).^2 + scale(:,:,2).^2 +scale(:,:,3).^2 + scale(:,:,4).^2),1,1,4);
q = repmat (scale,size(f,1)/4,1,1);


pr=eigen_reform(:,:,1);
pi=eigen_reform(:,:,2);
pj=eigen_reform(:,:,3);
pk=eigen_reform(:,:,4);

qr=q(:,:,1);
qi=q(:,:,2);
qj=q(:,:,3);
qk=q(:,:,4);

res_r=pr.*qr-pi.*qi-pj.*qj-pk.*qk;
res_i=pr.*qi+pi.*qr+pj.*qk-pk.*qj;
res_j=pr.*qj-pi.*qk+pj.*qr+pk.*qi;
res_k=pr.*qk+pi.*qj-pj.*qi+pk.*qr;

f(1:4:end,:)=res_r;
f(2:4:end,:)=res_i;
f(3:4:end,:)=res_j;

f(4:4:end,:)=res_k;

output=f;
end