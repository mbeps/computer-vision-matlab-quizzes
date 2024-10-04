clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load and convert the rooster image to double format
Ia = imread('/MATLAB Drive/assets/rooster.jpg');  % Load the rooster image
Iad = im2double(Ia);         % Convert to double format

% Create two Gaussians to simulate the centre and surround of the RF
gc = fspecial('gaussian', 9, 1);   % Centre Gaussian
gs = fspecial('gaussian', 9, 1.5); % Surround Gaussian

% Simulate the responses of colour opponent cells
% Red-on, Green-off
IaRG = conv2(Iad(:,:,1), gc, 'same') - conv2(Iad(:,:,2), gs, 'same');

% Green-on, Red-off
IaGR = conv2(Iad(:,:,2), gc, 'same') - conv2(Iad(:,:,1), gs, 'same');

% Blue-on, Yellow-off
yellow = mean(Iad(:,:,1:2), 3);  % Create yellow channel by averaging red and green
IaBY = conv2(Iad(:,:,3), gc, 'same') - conv2(yellow, gs, 'same');

% Yellow-on, Blue-off
IaYB = conv2(yellow, gc, 'same') - conv2(Iad(:,:,3), gs, 'same');

% Display the results in subplots
figure;
subplot(2,2,1), imagesc(IaRG), title('Red-on, Green-off'), colormap('gray'), colorbar;
subplot(2,2,2), imagesc(IaGR), title('Green-on, Red-off'), colormap('gray'), colorbar;
subplot(2,2,3), imagesc(IaBY), title('Blue-on, Yellow-off'), colormap('gray'), colorbar;
subplot(2,2,4), imagesc(IaYB), title('Yellow-on, Blue-off'), colormap('gray'), colorbar;

% Extract pixel intensity values at row=340, column=2
pixel_RG = IaRG(340, 2);  % Red-on, Green-off
pixel_GR = IaGR(340, 2);  % Green-on, Red-off
pixel_BY = IaBY(340, 2);  % Blue-on, Yellow-off
pixel_YB = IaYB(340, 2);  % Yellow-on, Blue-off

% Display the extracted pixel values
disp(['Red-on, Green-off: ', num2str(pixel_RG)]);
disp(['Green-on, Red-off: ', num2str(pixel_GR)]);
disp(['Blue-on, Yellow-off: ', num2str(pixel_BY)]);
disp(['Yellow-on, Blue-off: ', num2str(pixel_YB)]);

% Round the pixel values to 2 decimal places
pixel_RG_rounded = round(pixel_RG, 2);
pixel_GR_rounded = round(pixel_GR, 2);
pixel_BY_rounded = round(pixel_BY, 2);
pixel_YB_rounded = round(pixel_YB, 2);

% Display the rounded pixel values
disp(['Red-on, Green-off (rounded): ', num2str(pixel_RG_rounded)]);
disp(['Green-on, Red-off (rounded): ', num2str(pixel_GR_rounded)]);
disp(['Blue-on, Yellow-off (rounded): ', num2str(pixel_BY_rounded)]);
disp(['Yellow-on, Blue-off (rounded): ', num2str(pixel_YB_rounded)]);
