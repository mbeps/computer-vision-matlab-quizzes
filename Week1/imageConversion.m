% Clear previous data and setup
clear;
clc;
close all;

% Load the rooster image from the assets folder
Ia = imread('/MATLAB Drive/assets//rooster.jpg');

% Convert RGB to grayscale (intensity format)
Igray = rgb2gray(Ia);

% Convert the grayscale image from uint8 to double
Igray_double = im2double(Igray);

% Extract and display pixel intensity values at specified coordinates
pixel1 = Igray_double(317, 101);
pixel2 = Igray_double(194, 177);
pixel3 = Igray_double(149, 30);

% Display the values
disp(['Pixel intensity at (317,101): ', num2str(pixel1)]);
disp(['Pixel intensity at (194,177): ', num2str(pixel2)]);
disp(['Pixel intensity at (149,30): ', num2str(pixel3)]);
