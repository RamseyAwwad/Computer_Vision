

% QUESTION 2
im1 = imread('woman_happy.png');
im2 = imread('woman_neutral.png');

im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

im1 = imresize(im1, [500 500]);
im2 = imresize(im2, [500 500]);

% QUESTION 3
im1_blur = imgaussfilt(im1, 10, 'FilterSize', 31);
im2_blur = imgaussfilt(im2, 10, 'FilterSize', 31);

% QUESTION 4
im2_detail = im2 - im2_blur;

% QUESTION 5
im1_im2 = im1_blur + im2_detail;
imshow(im1_im2);
saveas(gcf, 'hybrid.png');
