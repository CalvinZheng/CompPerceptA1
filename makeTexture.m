function I = makeTexture(N)

%  choose your exponent !
oneoverf = makeOneOverf(N,1);  % the second argument is the exponent 1/f^e

%generate white noise
I = rand(N,N);

% weight the Fourier coefficients so they fall off like 1/k  
% (also known as "1/f noise", where "f" here means "frequency")
% Such images are sometimes called fractals.
%

%  The fftshift function rotates the frequencies by N/2 in each 
%  dimension, shifting the element (N/2+1,N/2+1) to the bottom 
%  left corner, namely (1,1).

I = ifft2(fft2(I) .* fftshift(oneoverf));

% Remap the intensities to [0,1] so we can look at them.

meanI = mean(I(:));
stdI  = std(I(:));

Inormalized = normcdf(I, meanI, stdI);

% make the standard deviation be 0.2  (somewhat arbitrary)
I = I/std(I(:)) * 0.2;

% make more uniform
% I = normcdf(I, 0, 1);

% chop off values with absolute value > 1
I = max(  min(I ,1.0), -1.0); 

% stretch to be more uniform in [-1,1]
I = ((I > 0) .*  power(I, .7) - (I < 0) .* power(-I, .7));

%  remap to [0,1]
I = (I + 1)/2;