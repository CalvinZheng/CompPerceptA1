function Icontrast = setContrast(I, michelsonContrast)
% rescale intensities to [0,1].   minimum maps to 0 and maximum maps to 1
%
Icontrast = (I - min(I(:)))/(max(I(:))-min(I(:)));
% shift to [-.5,.5]
Icontrast = Icontrast-.5;
% scale and shift back to lie within [0,1]
Icontrast = 0.5 + Icontrast * michelsonContrast;