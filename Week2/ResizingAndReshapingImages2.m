clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load and modify the image
Ib = imread('/MATLAB Drive/assets/elephant.png');
Ib(401:end, 401:end) = 255;

% Resize the image
Ibsmall2 = imresize(Ib, 0.5, 'nearest');
Iblarge2 = imresize(Ib, 2, 'bilinear');

% Extract pixel values
pixel1 = Ibsmall2(250, 235);  % At row=250, column=235 of Ibsmall2
pixel2 = Ib(250, 235);        % At row=250, column=235 of Ib
pixel3 = Iblarge2(250, 235);  % At row=250, column=235 of Iblarge2
pixel4 = Ib(500, 470);        % At row=500, column=470 of Ib
pixel5 = Iblarge2(1000, 940); % At row=1000, column=940 of Iblarge2

% Display the results
disp(['Pixel intensity at (250,235) of Ibsmall2: ', num2str(pixel1)]);
disp(['Pixel intensity at (250,235) of Ib: ', num2str(pixel2)]);
disp(['Pixel intensity at (250,235) of Iblarge2: ', num2str(pixel3)]);
disp(['Pixel intensity at (500,470) of Ib: ', num2str(pixel4)]);
disp(['Pixel intensity at (1000,940) of Iblarge2: ', num2str(pixel5)]);
