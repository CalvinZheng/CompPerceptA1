
close all
clear

maxSigma = 5;

I = double(rgb2gray(imread('nature.png')));

figure
subplot(1,2,1);
colormap(gray(256));
image(I)

sizeI = size(I);
Nrows = sizeI(1);

raisedCosine	= (make2Dcosine(Nrows, 4, 0) + 1)/2;
sigmaStepSize   =  .1;
numSigmas   =   ceil(maxSigma / sigmaStepSize )+1;   % +1 or else there would be pixels with 0 values

sigmaSteps = (maxSigma * raisedCosine) / sigmaStepSize;
Iblur = zeros(Nrows,Nrows);

for sigmaCt = 1:numSigmas

    %  Index the pixels whose sigma value,  gradientSigma*distFromCenter,
    %  lies in the bin [sigmaStep *(sigmaCt - 1), sigmaStep *sigmaCt).
    %  The variable indx is a boolean array, used to select a subset of 
    %  pixels that satisfies some criterion.  
    
    indx = ( sigmaSteps >= sigmaCt - 1 ) & ( sigmaSteps < sigmaCt );

    %  Let sig be the quantized sigma value that is used for these pixels.

    sig = (sigmaCt-1)*sigmaStepSize;

    if (max(indx(:) > 0))     %  only bother if at least one pixel is indexed.

    %  Blur the whole image by sig.   
        
       gaussian2D = make2DGaussian(sig);
       IblurSig =  conv2( double(I), gaussian2D, 'same');  %  'same' makes output size
                                                           %  same as input size
       
    %  Assign the intensity values of the blur image to the indexed pixels.
    %  Non-indexed pixels keep their old values.
    
       Iblur = (1-indx) .* Iblur  +  indx .* IblurSig; 

    end

end

subplot(1,2,2);
Iblur = remapImageUint8(Iblur);
image(Iblur)
imwrite(Iblur, 'blurred.png');
    