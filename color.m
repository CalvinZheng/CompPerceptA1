 
%   color.m
%
%   author:  Michael Langer
%   
%   Assignment 1  COMP 546/598  Fall 2015

close all
clear

I = imread('green.jpg');

sizeI = size(I);
Nrows = sizeI(1);
Ncols = sizeI(2);

%  save the redgreenB channels as double arrays.  This will be convenient for
%  vectorization later.

IRed   = double( I(:,:,1));
IGreen = double( I(:,:,2));
IBlue  = double( I(:,:,3));

figure          
image(I)
title(' original ')

%  Here we define the luminance, red-green, and blue-yellow axes

Vlum = [1, 1, 1];  
Vlum = Vlum / norm(Vlum); 
Vredgreen  = [ 1, -1, 0 ] ;
Vredgreen = Vredgreen / norm(Vredgreen); 
Vblueyellow  = [ 1, 1, -2 ] ;
Vblueyellow = Vblueyellow / norm(Vblueyellow); 
 
V = [Vlum; Vredgreen; Vblueyellow];

%  rotate redgreenB to luminance

lum =     Vlum(1) * IRed + ...         %  Nrows x Ncols 
          Vlum(2) * IGreen + ...
          Vlum(3) * IBlue;   

redgreen =      Vredgreen(1) * IRed + ...         %  Nrows x Ncols 
                Vredgreen(2) * IGreen + ...
                Vredgreen(3) * IBlue;   

blueyellow =  Vblueyellow(1) * IRed + ...         %  Nrows x Ncols 
              Vblueyellow(2) * IGreen + ...
              Vblueyellow(3) * IBlue;

f=figure;
figure(f);
subplot(3,2,1);
im = remapImageUint8(lum);
image(im)
colormap(gray(256)) 
title(' luminance ')
imwrite(im, 'lum.jpg');    %  prints image only (no title)
%print('lum', '-djpeg ');   %  prints figure (with title)          
      
subplot(3,2,3);
im = remapImageUint8(redgreen);
image(im)
colormap(gray(256)) 
title(' red-green ')

subplot(3,2,5);        
im = remapImageUint8(blueyellow);
image(im)
colormap(gray(256)) 
title(' blue-yellow ')

%---------   ADD YOUR CODE HERE  ---------------

%  Solution for Q1a

CRed = 128./((IRed+IGreen+IBlue)./3).*IRed;
CGreen = 128./((IRed+IGreen+IBlue)./3).*IGreen;
CBlue = 128./((IRed+IGreen+IBlue)./3).*IBlue;

CI = remapImageUint8(cat(3,CRed,CGreen,CBlue));

figure
image(CI)
title(' chromaticity-only ')

imwrite(CI, 'chromaticity-only.png');

%  Solution for Q1b

SobelX = [-1 0 1; -2 0 2; -1 0 1];
SobelY = [-1 -2 -1; 0 0 0; 1 2 1];

Glum = sqrt(conv2(lum, SobelX).^2 + conv2(lum, SobelY).^2);
Gredgreen = sqrt(conv2(redgreen, SobelX).^2 + conv2(redgreen, SobelY).^2);
Gblueyellow = sqrt(conv2(blueyellow, SobelX).^2 + conv2(blueyellow, SobelY).^2);

figure(f)
subplot(3,2,2)
image(remapImageUint8(Glum))
title(' luminance-edge ')

subplot(3,2,4)
image(remapImageUint8(Gredgreen))
title(' red-green-edge ')

subplot(3,2,6)
image(remapImageUint8(Gblueyellow))
title(' blue-yellow-edge ')

