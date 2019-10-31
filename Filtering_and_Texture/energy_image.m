function [energyImage, Ix, Iy] = energy_image(im)
% compute the energy at each pixel using the magnitude of the x and y gradients
im = rgb2gray(im);
% Ix, Iy are the gradients in the x and y directions, i.e. the dI/dx and dI/dy; use two of the 
% filters we discussed in class to compute them. Don't use Matlab's imgradient function but you 
% are welcome to use imfilter.

% these are the filters
hX = [1, 0 , -1];
hY = [1; 0; -1];

% compute derivative of image using filters
Ix = imfilter(im,hX,'same');
Iy = imfilter(im, hY, 'same'); 

px = power(Ix, 2);
py = power(Iy,2);

px = cast(px, 'double');
py = cast(py, 'double');

% sqrt(Ix)^2+(dI/dy)^2)   sqrt((dI/dx)^2+(dI/dy)^2).
energyImage = sqrt(px+py);
