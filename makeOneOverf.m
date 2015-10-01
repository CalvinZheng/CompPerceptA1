function  oneOverf = makeOneOverf(N,beta)
%
%  Returns a square matrix whose values are the inverse of the distance
%  to the center element.
%
kxVals = (1:N)' * ones(1,N);
kyVals = ones(N,1) * (1:N);
xcenter = N/2+1;
ycenter = N/2+1;

% Define a map which indicates the distance from each pixel to the image
% center.   Add a small constant to avoid division by zero in the last line
% below.

distFromCenter = .001 + sqrt(  (kxVals - xcenter).*(kxVals - xcenter) + ...
                        (kyVals - ycenter).*(kyVals - ycenter));

oneOverf = power((1./distFromCenter),beta) .* ...
    double((distFromCenter>=1) & (distFromCenter < N/2));

