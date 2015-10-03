%  Comp 546 Assignment 1 
%  Solution Question 2

%  Make an image which is a random texture defined by "1/f noise"
%  (which you need not try to understand at this point in the course).

%N             = 512;
%Ibackground  = makeTexture(N);
Ibackground = double(rgb2gray(imread('nature.png')))./255;
sizeI = size(Ibackground);
N = sizeI(1);

figure

%  Here we use a simple model of image blending in which a constant image
%  is blended with a texture/noise image.   

%  Let alpha be the "opacity" of a foreground layer which we will set to
%  be a cosine function and will have constant grey level intensity I_foreground.   
%  Note that  1-alpha is the "transparency" of that foreground layer, 
%  which is a multiple of the background (texture) layer.

%  A raised cosine function goes from 0 to 1.
raisedCosine         = (make2Dcosine(N, 4, 0) + 1)/2;

alphaMin = 0;       %  You need to change these values.
alphaMax = 0.4;       %       "

%  Define the opacity function for the foreground layer.
alpha = alphaMin + (alphaMax - alphaMin) * raisedCosine;

Iforeground = 1.0;    %  Do not change this.  (Making this smaller would give the 
                      %  foreground a dark color.)

%  Blend the (constant) foreground with the background texture.


I = (alpha * Iforeground +  (1-alpha) .* Ibackground ) *  255;
I = remapImageUint8(I);
image(I);
imwrite(I,'layered.png');

colormap(gray(255));
axis square