%   function remapImage.m
%
%   Take an image which may have positive and negative values and
%   remap the values so that 0 maps to 127 and the range is within
%   0 to 255.
%   If all values are positive, then remap 0 to 0 and range is 0 to 255

function vNormalized = remapImageUint8(image)
if min(image(:)) < 0
    vNormalized = uint8(127 + 128*image/max(abs(image(:))) );
else
    vNormalized = uint8(255*image/max(abs(image(:))) );
end
