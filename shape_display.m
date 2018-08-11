function shape_display(V,F,val)
if ~exist('val','var') || isempty(val)
    val = ones(size(V,1),1);
end
%val = (val - min(val(:))) / (max(val) - min(val));
h= patch('Faces', F, 'Vertices', V, 'FaceColor', 'flat', 'FaceVertexCData',val,'EdgeColor','black');
axis equal; axis tight; axis off; cameratoolbar; 
%colorbar;
%shading interp
end