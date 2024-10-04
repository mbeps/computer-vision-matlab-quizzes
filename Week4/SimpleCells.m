clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load the elephant image and convert it to double format
I = imread('/MATLAB Drive/assets/elephant.png');
I_double = im2double(I); % Convert image from uint8 to double

% Parameters for the Gabor filter
sigma = 3;
lambda = 0.1;
theta = 90;       % Orientation in degrees
gamma = 0.75;
phase = 90;       % Phase for the Gabor filter

% Generate the Gabor filter
gaborFilter = gabor2(sigma, lambda, theta, gamma, phase);

% Convolve the image with the Gabor filter (valid shape)
gaborResponse = conv2(I_double, gaborFilter, 'valid');

% Display the result of the convolution
figure;
imagesc(gaborResponse); 
colormap('gray');
colorbar;
title('Simple Cell Response (Gabor Filter with Phase 90)');

% Extract the values at the specified locations
value_1 = gaborResponse(360, 414); % Row 360, Column 414
value_2 = gaborResponse(276, 208); % Row 276, Column 208

% Display the values rounded to 2 decimal places
disp(['Value at row=360, column=414: ', num2str(round(value_1, 2))]);
disp(['Value at row=276, column=208: ', num2str(round(value_2, 2))]);
