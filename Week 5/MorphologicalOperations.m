clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

% Load the boat image and convert it to double format
I = imread('/MATLAB Drive/assets/boat.png');
I = im2double(rgb2gray(I));

% Segment the image as previously described
Iseg = zeros(size(I));
Iseg(I >= 0.68) = 0;
Iseg(I < 0.68 & I >= 0.47) = 1;
Iseg(I < 0.47 & I >= 0.37) = 2;
Iseg(I < 0.37) = 3;

% Define a circular structuring element with a radius of 3 pixels
se = strel('disk', 3);

% Perform morphological operations
Iseg_dilated = imdilate(Iseg, se);
Iseg_eroded = imerode(Iseg, se);
Iseg_opened = imopen(Iseg, se);
Iseg_closed = imclose(Iseg, se);

% Display the results
figure;
subplot(2,2,1), imagesc(Iseg_dilated), title('Dilated'), colormap('jet'), colorbar;
subplot(2,2,2), imagesc(Iseg_eroded), title('Eroded'), colormap('jet'), colorbar;
subplot(2,2,3), imagesc(Iseg_opened), title('Opened'), colormap('jet'), colorbar;
subplot(2,2,4), imagesc(Iseg_closed), title('Closed'), colormap('jet'), colorbar;

% Extract the pixel intensity values at row=220, column=1 for each operation
value_dilated = Iseg_dilated(220, 1);
value_eroded = Iseg_eroded(220, 1);
value_opened = Iseg_opened(220, 1);
value_closed = Iseg_closed(220, 1);

% Display the extracted values
disp(['Iseg dilated at (220,1): ', num2str(value_dilated)]);
disp(['Iseg eroded at (220,1): ', num2str(value_eroded)]);
disp(['Iseg opened at (220,1): ', num2str(value_opened)]);
disp(['Iseg closed at (220,1): ', num2str(value_closed)]);
