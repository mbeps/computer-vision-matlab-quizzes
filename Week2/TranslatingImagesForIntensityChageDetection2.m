clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load and modify the elephant image
Ib = imread('/MATLAB Drive/assets/elephant.png');  % Load the elephant image
Ib(401:end, 401:end) = 255;   % Modify the image (make a region white)

% Convert to double format
Ibd = im2double(Ib);

% Compute vertical and horizontal differences
Ibdiffv = Ibd(1:end-1, :) - Ibd(2:end, :);
Ibdiffh = Ibd(:, 1:end-1) - Ibd(:, 2:end);

% Compute the L2-norm (combined difference)
Ibdiff = sqrt(Ibdiffh(1:end-1, :).^2 + Ibdiffv(:, 1:end-1).^2);

% Convert to binary image
bw = im2bw(Ibdiff, 0.075);

% Extract pixel values
pixel1 = Ibdiffv(498, 400);
pixel2 = Ibdiffh(498, 400);
pixel3 = Ibdiff(498, 400);
pixel4 = bw(498, 400);

% Display results
disp(['Pixel intensity at (498,400) of Ibdiffv: ', num2str(pixel1)]);
disp(['Pixel intensity at (498,400) of Ibdiffh: ', num2str(pixel2)]);
disp(['Pixel intensity at (498,400) of Ibdiff: ', num2str(pixel3)]);
disp(['Pixel intensity at (498,400) of bw: ', num2str(pixel4)]);
