## General Information

This coursework is formative, meaning that it is designed to facilitate learning not to assess what you know. This means that the mark you obtain in this exercise does **NOT** contribute to your final mark for the module: the mark you achieve is purely to help you gauge how well you have understood and can apply the methods you have been taught.

This exercise will allow you to apply knowledge gained in lectures and tutorials to more practical problems using more realistic data, and hence, help consolidate and expand your knowledge. It will also allow you to develop coding skills that will be needed to complete the assessed coursework.

If you need clarification on the instructions or other help, then please ask: the KEATS forum is the best place to do this. Alternatively, you can submit arbitrary answers and you will then be able to see an explanation of what you should have done to get the correct answer, or at the minimum be told the correct answer so that you can work backwards to determine how you should have obtained this answer. Any suggestions as to how to make the instructions clearer are also most welcome.

You do not need to complete this exercise in one go. You can leave KEATS and return at a later time and continue from where you left off.

In general, for numerical values that are non-integer real numbers, it is necessary to provide answers correct to at least **2 decimal places**, which means that calculations should be performed with a precision of at least **4 decimal places**. For example, if you are asked to report the answer correct to at least 2 decimal places, and the correct answer is `5.2689` (to 4 decimal places), then all of these answers are correct: `5.2689`, `5.269`, `5.27`. In contrast, the following answers would be incorrect: `5.26` (because this has been rounded to 2 decimal places incorrectly), `5.2`, `5.3` (because these answers do not contain sufficient decimal places). 

Note that the decimal point must be a period (`.`) not a comma (`,`). Do **NOT** enter white-space characters in the answer boxes.

---

## Introduction

This exercise provides the opportunity to experiment with a number of image processing techniques used for low-level computer vision.

Remember that commands which you can type at the MATLAB prompt are indicated by text in the following typeface:

```matlab
matlab_function(parameter1, parameter2);
```

You will work with the rooster, elephant, and boxes images. Copy the `rooster.jpg`, `elephant.png`, and `boxes.pgm` files from the module's KEATS webpage to the directory in which you are running MATLAB, and load these images into MATLAB by using the following commands:

```matlab
Ia = imread('rooster.jpg');
Ib = imread('elephant.png');
Ic = imread('boxes.pgm');
```

Once you load these images into MATLAB, convert colour images to grayscale (i.e. intensity) images, and convert all images from integer format to double format. Use these converted images throughout the rest of this exercise. For example, when the instructions tell you to use the rooster image, it means that you should use the grayscale floating-point version of this image.

This MATLAB exercise will make extensive use of convolution. In MATLAB, 2-D convolution is performed using the function `conv2(I, H, shape)`, where `I` is a 2-dimensional matrix representing the image, `H` is a matrix representing the mask, and `shape` is a parameter defining the size of the output. To perform convolution on a colour image we need to convert the image to grayscale (or apply the convolution to a single channel of the image).

Execute the command:

```matlab
help conv2
```

Determine what values of the parameter `shape` can be used.

MATLAB provides a command `fspecial` that can generate some masks commonly used in image processing.

Execute the command:

```matlab
help fspecial
```

Determine what parameter values are required to generate a box (or average) mask and a Gaussian mask.

---

## Box Masks

A box, or average, mask is just an array of equal numbers that sum to one. Such a mask when convolved with an image provides smoothing.

Use the command `ones` or the command `fspecial` to create a `5x5` box mask and a `25x25` box mask. Ensure these are correctly normalised.

Convolve both the rooster (converted to grayscale) and boxes images with each of the box masks so that the resulting outputs are the same size as the original images.

Display the output of each convolution as a subplot in the same window. Use a "gray" colormap and provide a colorbar for each image.

---

## Gaussian Masks

Repeat the procedure described in the preceding section using two Gaussian masks (generated using the `fspecial` command) with standard deviations `1.5` and `10`. Ensure the size of each mask is sufficient to accurately represent the Gaussian.

---

## First-Derivative Masks

The first derivative in the y-direction can be approximated by convolving an image with the following mask: `[-1;1]`.  
The first derivative in the x-direction can be approximated by convolving an image with the following mask: `[-1,1]`.

Convolve the elephant image with both these masks, using the "valid" shape option, and show the results.

---

## Laplacian Masks

In two dimensions, a finite difference approximation to the second derivative is given by a Laplacian mask:

```
-1/8  -1/8  -1/8           -1   -1   -1
-1/8    1   -1/8     or    -1    8   -1
-1/8  -1/8  -1/8           -1   -1   -1
```

(Strictly speaking, these masks are the additive inverse of the Laplacian, and hence, approximate the minus of the second derivative).

Convolve both the rooster image and the boxes image with the Laplacian with the smaller amplitude, as defined on the left above. Ensure that the output of the convolution is the same size as the input image. Show the results.

---

## Gaussian Derivative Masks

To perform edge detection (i.e. to locate intensity discontinuities in an image that are more likely to be meaningful), first and second-order derivative masks are usually combined with a Gaussian mask to help suppress noise. Combining first derivative masks with a Gaussian results in Gaussian derivative masks.

Create two Gaussian derivative masks (one for the derivative in the x-direction, and one for the derivative in the y-direction). To do this, convolve a 2-D Gaussian (with standard deviation 2.5) once with the mask `[-1,1]` and once with the transpose of this mask. Ensure that the size of the resulting mask is sufficiently large to accurately represent the Gaussian derivative function.

Generate mesh plots of the two Gaussian derivative masks you have created, put these plots as `subplot(2,2,1)` and `subplot(2,2,2)` in a figure. Convolve the boxes image with each of the two Gaussian derivative masks you have created (using "same" as the shape parameter for the `conv2` function). Display images showing the output of these two convolutions as `subplot(2,2,3)` and `subplot(2,2,4)` in the same figure window.

The result is two images: one with large values at the locations where there are vertical discontinuities in the boxes image, and one where there are horizontal discontinuities. It is possible to combine these into a single image showing intensity-level discontinuities in both directions. This is achieved using the L2-norm, as follows:

```matlab
Icdg = sqrt(Icdgx.^2 + Icdgy.^2);
```

The above assumes that you have given your image convolved with the horizontal Gaussian derivative mask the variable name `Icdgx`, and that you have given your image convolved with the vertical Gaussian derivative mask the variable name `Icdgy`. Create an image showing the L2-norm image generated.

---

## Canny Edge Detection

Gaussian Derivative Masks (see the previous section) are the basis for the Canny edge detector. In MATLAB, the Canny edge detector is implemented by the command: 

```matlab
edge(I, 'Canny');
```

Hence, we can apply the Canny edge detector to the boxes image, using the following code:

```matlab
figure(9), clf
IcCanny = edge(Ic, 'Canny');
imagesc(IcCanny), title('Canny'); colormap('gray'); axis('equal', 'tight'); colorbar
```

This produces the following result:

Compare this result with those obtained with the Gaussian Derivative Masks.

Observe that the output generated by the Canny edge detector is similar to that obtained by combining, using the L2-norm, the two outputs produced by the x- and y-Gaussian Derivative masks. The difference is that the result has been thinned (so that the high values are one pixel wide) and binarized (so that the output is either 0 or 1, where 1 indicates a location with an intensity discontinuity). The false intensity discontinuities where the white squares meet the borders of the image have also been suppressed. These false discontinuities are caused when the image is padded with zeros in order to convolve the image with the Gaussian Derivative masks.

---

## Gaussian Image Pyramid

A Gaussian image pyramid is a multiscale representation of a single image at different resolutions. The first image in a Gaussian image pyramid is the original image. Subsequent images in the pyramid are created by recursively convolving the current image with

 a Gaussian mask and down-sampling.

Create a four-level Gaussian image pyramid of the rooster image, using a Gaussian with a standard deviation of 1.5, using "same" as the shape parameter for the `conv2` function, and resizing by a scale factor of 0.5 using nearest-neighbour interpolation. Display the images in the pyramid as four subplots in the same window.