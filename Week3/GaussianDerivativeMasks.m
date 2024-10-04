clear;
clc;
close all;

% Load the boxes image
boxes_img = imread('/MATLAB Drive/assets/boxes.pgm');

% Convert the image to double
boxes_gray = im2double(boxes_img);

% Define a 2-D Gaussian mask with standard deviation 2.5
gaussian_mask = fspecial('gaussian', [25 25], 2.5);

% Define the first derivative masks
dx_mask = [-1, 1];  % Derivative in x-direction
dy_mask = [-1; 1];  % Derivative in y-direction

% Convolve Gaussian mask with derivative masks to get Gaussian derivative masks
gaussian_deriv_x = conv2(gaussian_mask, dx_mask, 'same');
gaussian_deriv_y = conv2(gaussian_mask, dy_mask, 'same');

% Generate mesh plots of the two Gaussian derivative masks
figure;
subplot(2,2,1);
mesh(gaussian_deriv_x);
title('Gaussian Derivative Mask in X-Direction');

subplot(2,2,2);
mesh(gaussian_deriv_y);
title('Gaussian Derivative Mask in Y-Direction');

% Convolve the boxes image with the Gaussian derivative masks
Icdgx = conv2(boxes_gray, gaussian_deriv_x, 'same');
Icdgy = conv2(boxes_gray, gaussian_deriv_y, 'same');

% Display the convolved images
subplot(2,2,3);
imagesc(Icdgx);
colormap('gray');
colorbar;
title('Boxes Image - X Derivative');

subplot(2,2,4);
imagesc(Icdgy);
colormap('gray');
colorbar;
title('Boxes Image - Y Derivative');

% Combine the two outputs using L2-norm
Icdg = sqrt(Icdgx.^2 + Icdgy.^2);

% Extract the pixel intensity values for the Gaussian derivative in x-direction at specific locations
val_20_39 = Icdgx(20, 39);
val_20_40 = Icdgx(20, 40);
val_20_41 = Icdgx(20, 41);
val_20_42 = Icdgx(20, 42);

% Display the pixel intensity values rounded to 2 decimal places
disp(['Pixel intensity at row=20, column=39 (x-derivative): ', num2str(round(val_20_39, 2))]);
disp(['Pixel intensity at row=20, column=40 (x-derivative): ', num2str(round(val_20_40, 2))]);
disp(['Pixel intensity at row=20, column=41 (x-derivative): ', num2str(round(val_20_41, 2))]);
disp(['Pixel intensity at row=20, column=42 (x-derivative): ', num2str(round(val_20_42, 2))]);
