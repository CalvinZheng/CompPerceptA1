%  blurEccentric.m
%
%  COMP 546    Sept 2015
%  Michael Langer

%  Make an image which is a random texture defined by "1/f noise"
%  (which you need not try to understand at this point in the course).

N = 512;
I = makeTexture(N);
% 

contrast    =  0.8;   %  max 1.0
sigmaAtEdge =  2;     %  sigma at a distance which is the image half width

gradientSigma   =  sigmaAtEdge/(N/2);   % change in sigma  per pixel
sigmaStepSize   =  .1;   % we will quantize the sigma steps so that we can make use 
                         % of matlab's builtin conv function
                       
%  the sqrt(2) is used so that we blur all the way to the image corners                     
numSigmas   =   ceil( sqrt(2) * sigmaAtEdge / sigmaStepSize );   

xvals = (1:N)' * ones(1,N);
yvals = ones(N,1) * (1:N);
xcenter = N/2;
ycenter = N/2;

% Define a NxN map which indicates the distance from each pixel to the image
% center.
% 
% Notice the Matlab operator  .*  multiplies matrices element-by-element.

distFromCenter = sqrt(  (xvals - xcenter).*(xvals - xcenter) + ...
                        (yvals - ycenter).*(yvals - ycenter)       );

%  Here is our new image whose blur will depend on eccentricity 

Iblur = zeros(N,N);
figure; 

%  Define another map which we will quantize into steps, 1, 2, 3, ...
%  like rings of a dart board

sigmaSteps = (gradientSigma * distFromCenter) / sigmaStepSize;
    
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
 
    %  If you want to visualize how the image is constructed then 
    %  change the following line to "if (1)"

        if (0)
         imagesc( Iblur ); 
         colormap gray;  axis square; 
         pause(1);
         hold on;
       end
    end

end


%%   Now change the contrast

IblurContrast = setContrast(Iblur,contrast); 

%create little black square in centers
halfwidth = 5;
IblurContrast(N/2-halfwidth:N/2+halfwidth,...
    N/2-halfwidth:N/2+halfwidth) =  0; 
%  We will use the 'image' function below which expects colormap indices.
%  The default colormap has 64 indices (1 to 64).
IblurContrast = uint8(ceil(IblurContrast*64));

Ifixate = ones(N,N)*32;
Ifixate(N/2-halfwidth:N/2+halfwidth,...
    N/2-halfwidth:N/2+halfwidth) =  0; 

image(Ifixate); 
colormap gray; axis square;  hold on; pause(1);
image(IblurContrast); 
xlabel(['Iblur,    sigma at edge is ' num2str(sigmaAtEdge) ' pixels, contrast=' num2str(contrast)]);  
%pause(.5); close


%  clear

%  safer to clear all variables afterwards,  but I comment this out in case
%  you want to examine the values of the variables after program is done