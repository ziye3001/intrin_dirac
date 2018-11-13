%Construct the quaternionic diagonal matrix by m =
%diag(x1,x1,x1,x1,...,xn,xn,xn,xn)
function m = quaternion_diag(x)

if size(x,2) ==1
    m= spdiags(reshape(transpose(repmat(x,1,4)),[],1),0,4*size(x,1),4*size(x,1));
elseif size(x,2) == 4
    dim = size(x,1);
    II = transpose(reshape(repmat(1:4*dim,4,1),16,[]));
    JJ = repmat(transpose(reshape((1:4*dim)',4,[])),1,4);
    
      Q = [ ...
    1 0 0 0;0 -1  0 0;0 0 -1  0;0  0 0 -1; ...
    0 1 0 0;1  0  0 0;0 0  0 -1;0  0 1  0; ...
    0 0 1 0;0  0  0 1;1 0  0  0;0 -1 0  0; ...
    0 0 0 1;0  0 -1 0;0 1  0  0;1  0 0  0]';
    m = sparse(II,JJ, x*Q, 4*dim,4*dim);
end

end