clear;           % Clear workspace
clc;             % Clear command window
close all;       % Close any open figure windows

% Load and convert the rooster image to grayscale and double format
Ia = imread('/MATLAB Drive/assets/rooster.jpg');
Igray = rgb2gray(Ia); 
Igray = im2double(Igray);

% Create a Gaussian mask with standard deviation of 1.5
gaussianMask = fspecial('gaussian', [5, 5], 1.5);

% Create a Gaussian pyramid (4 levels)
pyramid = cell(1,4); % To store the pyramid levels
pyramid{1} = Igray;  % The original image is the first level

for i = 2:4
    % Convolve the image with the Gaussian mask
    blurredImage = conv2(pyramid{i-1}, gaussianMask, 'same');
    
    % Downsample the image by a scale factor of 0.5
    pyramid{i} = imresize(blurredImage, 0.5, 'nearest');
end

% Display the pyramid
figure;
for i = 1:4
    subplot(2, 2, i);
    imagesc(pyramid{i});
    colormap('gray');
    colorbar;
    title(['Level ', num2str(i)]);
end

% Get the fourth level of the pyramid
fourthLevel = pyramid{4};

% Report the pixel intensity values at specified locations
value1 = fourthLevel(8, 23);  % Value at row=8, column=23
value2 = fourthLevel(17, 17); % Value at row=17, column=17

% Display the results
disp(['Pixel intensity at row=8, column=23: ', num2str(round(value1, 2))]);
disp(['Pixel intensity at row=17, column=17: ', num2str(round(value2, 2))]);
