clear;
clc;
close all;

% Load the rooster and boxes images
rooster_img = imread('/MATLAB Drive/assets/rooster.jpg');
boxes_img = imread('/MATLAB Drive/assets/boxes.pgm');

% Convert images to grayscale and double
rooster_gray = im2double(rgb2gray(rooster_img));  % Convert rooster to grayscale and double
boxes_gray = im2double(boxes_img);                % Convert boxes to double

% Define the Laplacian mask with smaller amplitude (1st mask)
laplacian_mask = [-1/8, -1/8, -1/8; -1/8, 1, -1/8; -1/8, -1/8, -1/8];

% Convolve both the rooster and boxes images with the Laplacian mask
rooster_lap = conv2(rooster_gray, laplacian_mask, 'same');
boxes_lap = conv2(boxes_gray, laplacian_mask, 'same');

% Display the results
figure;
subplot(1, 2, 1), imagesc(rooster_lap), colormap('gray'), colorbar;
title('Rooster Image Convolved with Laplacian');
subplot(1, 2, 2), imagesc(boxes_lap), colormap('gray'), colorbar;
title('Boxes Image Convolved with Laplacian');

% Extract pixel intensity values at the required locations for the boxes image
val_20_39 = boxes_lap(20, 39);
val_20_40 = boxes_lap(20, 40);
val_20_41 = boxes_lap(20, 41);
val_20_42 = boxes_lap(20, 42);

% Display the pixel intensity values rounded to 2 decimal places
disp(['Pixel intensity at row=20, column=39: ', num2str(round(val_20_39, 2))]);
disp(['Pixel intensity at row=20, column=40: ', num2str(round(val_20_40, 2))]);
disp(['Pixel intensity at row=20, column=41: ', num2str(round(val_20_41, 2))]);
disp(['Pixel intensity at row=20, column=42: ', num2str(round(val_20_42, 2))]);
