clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load the boat image and convert to double format
I = imread('/MATLAB Drive/assets/boat.png');
I_double = im2double(I);

% Convert to grayscale
I_gray = rgb2gray(I_double);

% Generate histograms
v_gray = I_gray(:);               % Vectorize grayscale image
v_r = I_double(:,:,1); v_r = v_r(:); % Vectorize red channel
v_g = I_double(:,:,2); v_g = v_g(:); % Vectorize green channel
v_b = I_double(:,:,3); v_b = v_b(:); % Vectorize blue channel

% Plot histograms
figure;
subplot(2,2,1);
hist(v_gray,64);
title('Grayscale Histogram');
subplot(2,2,2);
hist(v_r,64);
title('Red Channel Histogram');
subplot(2,2,3);
hist(v_g,64);
title('Green Channel Histogram');
subplot(2,2,4);
hist(v_b,64);
title('Blue Channel Histogram');

% Segment the grayscale image based on thresholds
segmented_image = zeros(size(I_gray)); % Initialize the segmented image

% Apply thresholds to create the segmented image
segmented_image(I_gray >= 0.68) = 0;
segmented_image(I_gray < 0.68 & I_gray >= 0.47) = 1;
segmented_image(I_gray < 0.47 & I_gray >= 0.37) = 2;
segmented_image(I_gray < 0.37) = 3;

% Display the segmented image
figure;
imagesc(segmented_image);
colormap('jet');
colorbar;
title('Segmented Image');

% Extract values at the specified locations
value_1 = segmented_image(92, 91);    % Row 92, Column 91
value_2 = segmented_image(286, 279);  % Row 286, Column 279
value_3 = segmented_image(292, 299);  % Row 292, Column 299
value_4 = segmented_image(451, 352);  % Row 451, Column 352

% Display the extracted values
disp(['Value at row=92, column=91: ', num2str(value_1)]);
disp(['Value at row=286, column=279: ', num2str(value_2)]);
disp(['Value at row=292, column=299: ', num2str(value_3)]);
disp(['Value at row=451, column=352: ', num2str(value_4)]);
