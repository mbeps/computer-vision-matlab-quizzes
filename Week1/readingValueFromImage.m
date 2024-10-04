% Clear previous data and setup
clear;
clc;
close all;

% Load the elephant image
Ib = imread('assets/elephant.png');

% Extract and display pixel values at specified coordinates
pixel1 = Ib(48, 144);
pixel2 = Ib(414, 491);
pixel3 = Ib(209, 309);

% Display the values
disp(['Pixel intensity at (48,144): ', num2str(pixel1)]);
disp(['Pixel intensity at (414,491): ', num2str(pixel2)]);
disp(['Pixel intensity at (209,309): ', num2str(pixel3)]);
