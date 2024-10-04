clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load the elephant image and convert it to double format
I = imread('/MATLAB Drive/assets/elephant.png');
I_double = im2double(I); % Convert image from uint8 to double

% Parameters for the Gabor filters
sigma = 3;
lambda = 0.1;
theta = 90;       % Orientation in degrees
gamma = 0.75;

% Generate the first Gabor filter with phase = 90 degrees
gaborFilter90 = gabor2(sigma, lambda, theta, gamma, 90);
% Generate the second Gabor filter with phase = 0 degrees
gaborFilter0 = gabor2(sigma, lambda, theta, gamma, 0);

% Convolve the image with both Gabor filters (valid shape)
gaborResponse90 = conv2(I_double, gaborFilter90, 'valid');
gaborResponse0 = conv2(I_double, gaborFilter0, 'valid');

% Combine the two responses using the L2-norm
combinedResponse = sqrt(gaborResponse90.^2 + gaborResponse0.^2);

% Display the result of the L2-norm combination
figure;
imagesc(combinedResponse);
colormap('gray');
colorbar;
title('Complex Cell Response (L2-Norm of Gabor Filter Responses)');

% Extract the values at the specified locations
value_1 = combinedResponse(223, 192); % Row 223, Column 192
value_2 = combinedResponse(395, 240); % Row 395, Column 240

% Display the values rounded to 2 decimal places
disp(['Value at row=223, column=192: ', num2str(round(value_1, 2))]);
disp(['Value at row=395, column=240: ', num2str(round(value_2, 2))]);
