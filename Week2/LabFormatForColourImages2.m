clear;
clc;
close all;

% Load the rooster image
Ia = imread('/MATLAB Drive/assets/rooster.jpg');
Iad = im2double(Ia);  % Convert to double format

% Create two Gaussians for the centre and surround of the RF
gc = fspecial('gaussian', 9, 1);   % Centre Gaussian
gs = fspecial('gaussian', 9, 1.5); % Surround Gaussian

% Red-on, Green-off
IaRG = conv2(Iad(:,:,1), gc, 'same') - conv2(Iad(:,:,2), gs, 'same');

% Yellow-on, Blue-off
yellow = mean(Iad(:,:,1:2), 3);  % Create yellow channel by averaging red and green
IaYB = conv2(yellow, gc, 'same') - conv2(Iad(:,:,3), gs, 'same');

% Convert the image to Lab format
Ialab = rgb2lab(Iad);

% Extract values from Lab channels at row=100, column=100
L_value = Ialab(100, 100, 1);  % L-channel value
a_value = Ialab(100, 100, 2);  % a-channel value
b_value = Ialab(100, 100, 3);  % b-channel value

% Display the values rounded to 2 decimal places
disp(['L-channel: ', num2str(round(L_value, 2))]);
disp(['a-channel: ', num2str(round(a_value, 2))]);
disp(['b-channel: ', num2str(round(b_value, 2))]);

% Plot the comparison between RGB opponent cells and Lab format
Iagray = rgb2gray(Iad);

figure(10), clf, colormap('gray');
subplot(2,3,1); imagesc(Iagray); axis('off', 'equal', 'tight'); colorbar; title('intensity');
subplot(2,3,2); imagesc(IaRG); axis('off', 'equal', 'tight'); colorbar; title('red-on, green-off');
subplot(2,3,3); imagesc(IaYB); axis('off', 'equal', 'tight'); colorbar; title('yellow-on, blue-off');
subplot(2,3,4); imagesc(Ialab(:,:,1)); axis('off', 'equal', 'tight'); colorbar; title('L-channel');
subplot(2,3,5); imagesc(Ialab(:,:,2)); axis('off', 'equal', 'tight'); colorbar; title('a-channel');
subplot(2,3,6); imagesc(Ialab(:,:,3)); axis('off', 'equal', 'tight'); colorbar; title('b-channel');
