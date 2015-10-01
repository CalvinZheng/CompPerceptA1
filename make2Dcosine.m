function I = make2Dcosine(N,KX,KY)
%  I = make2Dcosine(N,KX,KY);
%
%  This program displays a 2D cosine wave cos( 2pi/N (KX x + KY y)).
%  where x,y can be float or double.

% cos( KX * X + KY * Y) =  cos( KX * X) * cos( KY * Y) - ...
%                          sin( KX * X) * sin( KY * Y);
 
%  Note:  X is horizontal,  Y is vertical.   X counts from left to right.
%  Y counts from top to bottom.   

I = cos(2*pi/N* (KY * (0:N-1)')) * cos(2*pi/N* KX * (0:N-1))  - ...
    sin(2*pi/N* (KY * (0:N-1)')) * sin(2*pi/N* KX * (0:N-1)) ;