clear;
clc;
close all;

% Load images and convert to grayscale and double format
Ia = imread('/MATLAB Drive/assets/rooster.jpg');      % Load rooster image
Ia_gray = rgb2gray(Ia);          % Convert to grayscale
Ia_double = im2double(Ia_gray);  % Convert to double format

Ib = imread('/MATLAB Drive/assets/boxes.pgm');        % Load boxes image
Ib_double = im2double(Ib);       % Convert to double format

% Create 5x5 and 25x25 box masks
mask_5x5 = fspecial('average', [5 5]);
mask_25x25 = fspecial('average', [25 25]);

% Convolve the images with the masks
Ia_conv_5x5 = conv2(Ia_double, mask_5x5, 'same');  % Rooster with 5x5 mask
Ia_conv_25x25 = conv2(Ia_double, mask_25x25, 'same');  % Rooster with 25x25 mask
Ib_conv_5x5 = conv2(Ib_double, mask_5x5, 'same');  % Boxes with 5x5 mask
Ib_conv_25x25 = conv2(Ib_double, mask_25x25, 'same');  % Boxes with 25x25 mask

% Display the results in subplots
figure;
subplot(2, 2, 1), imagesc(Ia_conv_5x5), title('Rooster - 5x5 Box Mask');
colormap('gray'), colorbar, axis('image', 'tight');
subplot(2, 2, 2), imagesc(Ia_conv_25x25), title('Rooster - 25x25 Box Mask');
colormap('gray'), colorbar, axis('image', 'tight');
subplot(2, 2, 3), imagesc(Ib_conv_5x5), title('Boxes - 5x5 Box Mask');
colormap('gray'), colorbar, axis('image', 'tight');
subplot(2, 2, 4), imagesc(Ib_conv_25x25), title('Boxes - 25x25 Box Mask');
colormap('gray'), colorbar, axis('image', 'tight');

% Extract pixel intensity values for the specified locations
pixel_ia_5x5 = Ia_conv_5x5(297, 220);
pixel_ia_25x25 = Ia_conv_25x25(297, 220);
pixel_ib_5x5 = Ib_conv_5x5(10, 78);
pixel_ib_25x25 = Ib_conv_25x25(10, 78);

% Display the pixel intensity values rounded to 2 decimal places
disp(['Pixel intensity at row=297, column=220 of rooster (5x5 box mask): ', num2str(round(pixel_ia_5x5, 2))]);
disp(['Pixel intensity at row=297, column=220 of rooster (25x25 box mask): ', num2str(round(pixel_ia_25x25, 2))]);
disp(['Pixel intensity at row=10, column=78 of boxes (5x5 box mask): ', num2str(round(pixel_ib_5x5, 2))]);
disp(['Pixel intensity at row=10, column=78 of boxes (25x25 box mask): ', num2str(round(pixel_ib_25x25, 2))]);
