clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load the boat image
I = imread('/MATLAB Drive/assets/boat.png');

% Convert image to single precision
I_single = im2single(I);

% Create meshgrid for x and y coordinates
[X, Y] = meshgrid(1:size(I,2), 1:size(I,1));

% Normalize X and Y to be in the same range as RGB values (0 to 1)
X_norm = (X - min(X(:))) / (max(X(:)) - min(X(:)));
Y_norm = (Y - min(Y(:))) / (max(Y(:)) - min(Y(:)));

% Concatenate RGB values with normalized X and Y coordinates
I_with_xy = cat(3, I_single, X_norm, Y_norm);

% Perform k-means clustering
k = 5;
Iseg = imsegkmeans(I_with_xy, k);

% Display the result
figure;
imagesc(Iseg);
colormap('default');
colorbar;
title('k-means Clustering on RGB with XY coordinates');

% Extract and display the requested values
locations = [58, 612; 145, 174; 168, 539; 349, 549; 374, 229];

for i = 1:size(locations, 1)
    row = locations(i, 1);
    col = locations(i, 2);
    value = Iseg(row, col);
    fprintf('Value at row=%d, column=%d: %d\n', row, col, value);
end