 
%   color.m
%
%   author:  Michael Langer
%   
%   Assignment 1  COMP 546/598  Fall 2015

close all
clear

I = imread('cows.jpg');

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

%  Here we define the luminance, red-green, and blue-yellow axes

Vlum = [1, 1, 1];  
Vlum = Vlum / norm(Vlum); 
Vredgreen  = [ 1/sqrt(2) -1/sqrt(2)  0 ] ;
Vredgreen = Vredgreen / norm(Vredgreen); 
Vblueyellow  = [ 1/sqrt(6)  1/sqrt(6) -2/sqrt(6) ] ;
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

figure          
im = remapImageUint8(lum);
image(im)
colormap(gray(256)) 
title(' luminance ')
imwrite(im, 'lum.jpg');    %  prints image only (no title)
%print('lum', '-djpeg ');   %  prints figure (with title)          
      
figure          
im = remapImageUint8(redgreen);
image(redgreen)
colormap(gray(256)) 
title(' red-green ')

figure          
im = remapImageUint8(redgreen);
image(im)
colormap(gray(256)) 
title(' blue-yellow ')

%---------   ADD YOUR CODE HERE  ---------------

%  Solution for Q1a


%  Solution for Q1b
