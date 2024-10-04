clear;           % Clears all variables from the workspace
clc;             % Clears the command window
close all;       % Closes all open figure windows

Ib = imread('/MATLAB Drive/assets/elephant.png');  % Load the modified elephant image
Ib(401:end, 401:end) = 255;   % Modify the image by making part of it white
Ic = imread('/MATLAB Drive/assets/woods.png');     % Load the woods image

function corr_coeffs = calc_corr_coeffs(I, max_shift)
    % Calculate correlation coefficients for shifts from 0 to max_shift
    corr_coeffs = zeros(1, max_shift);
    for shift = 1:max_shift
        I_shifted = I(shift+1:end, :);  % Shift the image vertically
        I_base = I(1:end-shift, :);     % Base image (without shift)
        corr_coeffs(shift) = corr2(I_base, I_shifted);  % Calculate correlation
    end
end


% Calculate correlation for up to 30-pixel shifts
max_shift = 30;
corr_elephant = calc_corr_coeffs(Ib, max_shift);
corr_woods = calc_corr_coeffs(Ic, max_shift);

% Extract the values for 3-pixel and 23-pixel shifts
corr_elephant_3 = corr_elephant(3);
corr_elephant_23 = corr_elephant(23);
corr_woods_3 = corr_woods(3);
corr_woods_23 = corr_woods(23);

% Display results
disp(['3-pixel shift correlation for elephant image: ', num2str(corr_elephant_3)]);
disp(['3-pixel shift correlation for woods image: ', num2str(corr_woods_3)]);
disp(['23-pixel shift correlation for elephant image: ', num2str(corr_elephant_23)]);
disp(['23-pixel shift correlation for woods image: ', num2str(corr_woods_23)]);

shifts = 1:max_shift;
figure;
plot(shifts, corr_elephant, '-o', shifts, corr_woods, '-x');
xlabel('Pixel Shift');
ylabel('Correlation Coefficient');
title('Correlation Coefficient vs. Vertical Pixel Shift');
legend('Elephant Image', 'Woods Image');
