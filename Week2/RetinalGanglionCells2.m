clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load and modify the image if not already done
Ib = imread('/MATLAB Drive/assets/elephant.png');
Ib(401:end, 401:end) = 255;   % Modify the image (white rectangular region)
Ibd = im2double(Ib);          % Convert to double format

% Generate the DoG mask
dog = fspecial('gaussian', 11, 1.25) - fspecial('gaussian', 11, 1.75);

% Convolve the DoG mask with the modified elephant image
Ibdog = conv2(Ibd, dog, 'same');

% Extract the pixel value at row=170, column=493
pixel_value = Ibdog(170, 493);

% Display the result
disp(['Pixel value at row 170, column 493: ', num2str(pixel_value)]);
