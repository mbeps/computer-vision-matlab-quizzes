clear;
clc;
close all;

% Load the elephant image and convert to double
Ib = imread('/MATLAB Drive/assets/elephant.png');
Ibd = im2double(Ib);  % Convert to double format

% First derivative in the y-direction
Ibdiffy = conv2(Ibd, [-1; 1], 'valid');
figure(3), clf, imagesc(Ibdiffy); colormap('gray'); colorbar;
title('First Derivative in Y-direction');

% First derivative in the x-direction
Ibdiffx = conv2(Ibd, [-1, 1], 'valid');
figure(4), clf, imagesc(Ibdiffx); colormap('gray'); colorbar;
title('First Derivative in X-direction');

% Extract pixel intensity values at the required locations
val_143_227_y = Ibdiffy(143, 227);  % row=143, column=227 in y-direction
val_143_227_x = Ibdiffx(143, 227);  % row=143, column=227 in x-direction
val_278_60_y = Ibdiffy(278, 60);    % row=278, column=60 in y-direction
val_278_60_x = Ibdiffx(278, 60);    % row=278, column=60 in x-direction

% Display the values rounded to 2 decimal places
disp(['First derivative at row=143, column=227 in y-direction: ', num2str(round(val_143_227_y, 2))]);
disp(['First derivative at row=143, column=227 in x-direction: ', num2str(round(val_143_227_x, 2))]);
disp(['First derivative at row=278, column=60 in y-direction: ', num2str(round(val_278_60_y, 2))]);
disp(['First derivative at row=278, column=60 in x-direction: ', num2str(round(val_278_60_x, 2))]);
