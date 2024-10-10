clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load the boat image
I = imread('/MATLAB Drive/assets/boat.png');

% Resize the image
Ismall = imresize(I, 0.25, 'bilinear');

% Reshape the image for clustering
[a, b, c] = size(Ismall);
Msmall = reshape(Ismall, [a*b, c]);

% Convert to double and scale RGB values
Msmall = double(Msmall);
Msmall = Msmall - min(Msmall);
Msmall = Msmall ./ max(Msmall);

% Apply hierarchical agglomerative clustering
Mseg = clusterdata(Msmall, 'cutoff', 0.3, 'criterion', 'distance', ...
                   'linkage', 'average', 'distance', 'euclidean');

% Reshape the result back to image dimensions
Iseg = reshape(Mseg, [a, b]);

% Display the result
figure;
imagesc(Iseg);
colormap('default');
colorbar;
title('Hierarchical Agglomerative Clustering on scaled RGB');

% Extract and display the requested values
locations = [2, 40; 46, 16; 80, 26; 88, 3; 88, 125];

for i = 1:size(locations, 1)
    row = locations(i, 1);
    col = locations(i, 2);
    value = Iseg(row, col);
    fprintf('Value at row=%d, column=%d: %d\n', row, col, value);
end