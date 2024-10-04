clear;
clc;
close all;

% Load images and convert to grayscale and double format
Ia = imread('/MATLAB Drive/assets/rooster.jpg');      % Load rooster image
Ia_gray = rgb2gray(Ia);          % Convert to grayscale
Ia_double = im2double(Ia_gray);  % Convert to double format

Ib = imread('/MATLAB Drive/assets/boxes.pgm');        % Load boxes image
Ib_double = im2double(Ib);       % Convert to double format

% Create Gaussian masks with std dev = 1.5 and 10
mask_gaussian_1_5 = fspecial('gaussian', [25 25], 1.5);
mask_gaussian_10 = fspecial('gaussian', [51 51], 10);

% Convolve the images with the Gaussian masks
Ia_conv_gaussian_1_5 = conv2(Ia_double, mask_gaussian_1_5, 'same');  % Rooster with Gaussian std=1.5
Ia_conv_gaussian_10 = conv2(Ia_double, mask_gaussian_10, 'same');    % Rooster with Gaussian std=10
Ib_conv_gaussian_1_5 = conv2(Ib_double, mask_gaussian_1_5, 'same');  % Boxes with Gaussian std=1.5
Ib_conv_gaussian_10 = conv2(Ib_double, mask_gaussian_10, 'same');    % Boxes with Gaussian std=10

% Display the results in subplots
figure;
subplot(2, 2, 1), imagesc(Ia_conv_gaussian_1_5), title('Rooster - Gaussian std=1.5');
colormap('gray'), colorbar, axis('image', 'tight');
subplot(2, 2, 2), imagesc(Ia_conv_gaussian_10), title('Rooster - Gaussian std=10');
colormap('gray'), colorbar, axis('image', 'tight');
subplot(2, 2, 3), imagesc(Ib_conv_gaussian_1_5), title('Boxes - Gaussian std=1.5');
colormap('gray'), colorbar, axis('image', 'tight');
subplot(2, 2, 4), imagesc(Ib_conv_gaussian_10), title('Boxes - Gaussian std=10');
colormap('gray'), colorbar, axis('image', 'tight');

% Extract pixel intensity values for the specified locations
pixel_ia_gaussian_1_5 = Ia_conv_gaussian_1_5(334, 213);
pixel_ia_gaussian_10 = Ia_conv_gaussian_10(334, 213);
pixel_ib_gaussian_1_5 = Ib_conv_gaussian_1_5(4, 47);
pixel_ib_gaussian_10 = Ib_conv_gaussian_10(4, 47);

% Display the pixel intensity values rounded to 2 decimal places
disp(['Pixel intensity at row=334, column=213 of rooster (Gaussian std=1.5): ', num2str(round(pixel_ia_gaussian_1_5, 2))]);
disp(['Pixel intensity at row=334, column=213 of rooster (Gaussian std=10): ', num2str(round(pixel_ia_gaussian_10, 2))]);
disp(['Pixel intensity at row=4, column=47 of boxes (Gaussian std=1.5): ', num2str(round(pixel_ib_gaussian_1_5, 2))]);
disp(['Pixel intensity at row=4, column=47 of boxes (Gaussian std=10): ', num2str(round(pixel_ib_gaussian_10, 2))]);
