## General Information
This coursework is formative, meaning that it is designed to facilitate learning not to assess what you know. This means that the mark you obtain in this exercise does **NOT** contribute to your final mark for the module: the mark you achieve is purely to help you gauge how well you have understood and can apply the methods you have been taught.

This exercise will allow you to apply knowledge gained in lectures and tutorials to more practical problems using more realistic data, and hence, help consolidate and expand your knowledge. It will also allow you to develop coding skills that will be needed to complete the assessed coursework.

If you need clarification on the instructions or other help, then please ask: the KEATS forum is the best place to do this. Alternatively, you can submit arbitrary answers and you will then be able to see an explanation of what you should have done to get the correct answer, or at the minimum be told the correct answer so that you can work backwards to determine how you should have obtained this answer. Any suggestions as to how to make the instructions clearer are also most welcome.

You do not need to complete this exercise in one go. You can leave KEATS and return at a later time and continue from where you left off.

In general, for numerical values that are non-integer real numbers, it is necessary to provide answers correct to at least **2 decimal places**, which means that calculations should be performed with a precision of at least **4 decimal places**. For example, if you are asked to report the answer correct to at least 2 decimal places, and the correct answer is `5.2689` (to 4 decimal places), then all of these answers are correct: `5.2689`, `5.269`, `5.27`. In contrast, the following answers would be incorrect: `5.26` (because this has been rounded to 2 decimal places incorrectly), `5.2`, `5.3` (because these answers do not contain sufficient decimal places). 

Note that the decimal point must be a period (`.`) not a comma (`,`). Do **NOT** enter white-space characters in the answer boxes.

---

## Introduction

This exercise will continue to introduce you to working with images in MATLAB. In addition, it will allow you to explore some topics that are covered in this week's lecture.

Remember that commands which you can type at the MATLAB prompt are indicated by text in the following typeface:

```matlab
matlab_function(parameter1, parameter2);
```

As in the previous MATLAB exercise, you will work with the rooster and elephant images, plus the woods image. Copy the `rooster.jpg`, `elephant.png`, and `woods.png` files from the module's KEATS webpage to the directory in which you are running MATLAB, and load these images into MATLAB by using the following commands:

```matlab
Ia = imread('rooster.jpg');
Ib = imread('elephant.png');
Ic = imread('woods.png');
```

---

## Image Modification

In the previous MATLAB exercise, you learnt how to read values from an image. We can use similar methods to assign values to locations in an image.

For example, the previous exercise explained that to see the value at row 403 and column 404 of the elephant image, you would use:

```matlab
Ib(403,404)
```

To change the value at row 403 and column 404 of the elephant image, you would use:

```matlab
Ib(403,404) = 1;
```

This will replace the previous value with a new value of `1`.

We can select larger parts of an image using MATLAB's standard "colon" operator. We can also replace parts of an image using this technique. Do the following, which will make a rectangular patch of the elephant image white:

```matlab
Ib(401:end, 401:end) = 255;
```

Perform the modifications described above, and see the effects by displaying the image:

```matlab
figure(1), clf
imagesc(Ib); colormap('gray')
```

We can go further and use this technique to create entirely synthetic images, e.g.:

```matlab
Isyn = zeros(201, 201);
Isyn(51:150, 51:150) = 1;
Isyn(81:120, :) = 0.5;
Isyn(:, 81:120) = 0.75;
figure(2), clf, imagesc(Isyn); colormap('gray')
```

---

## Resizing and Reshaping Images

Resizing, or scaling, an image can be done with the command `imresize`. Use the following commands to make copies of the (now modified) elephant image that are half and twice the original size. 

Note, this is to be done on the modified elephant image, so if you have not already done so, ensure you perform the steps described in the previous section before continuing.

```matlab
Ibsmall = imresize(Ib, 0.5);
Iblarge = imresize(Ib, 2);
```

To see the results:

```matlab
figure(3), clf
subplot(2,2,1), imagesc(Ibsmall); title('Half size')
subplot(2,2,2), imagesc(Iblarge); title('Double size')
```

Notice the difference in the axes labels.

When resizing an image, we can choose which method MATLAB employs by using an optional parameter (some of these methods have been discussed in the lecture when describing demosaicing). Make an image twice the original size using bilinear interpolation, by doing the following:

```matlab
Iblarge2 = imresize(Ib, 2, 'bilinear');
```

Make an image half the original size using nearest-neighbour interpolation, by doing the following:

```matlab
Ibsmall2 = imresize(Ib, 0.5, 'nearest');
```

Sometimes we might want to resize an image by padding or cropping: adding or removing rows and columns of pixels around the borders of the image. This is illustrated using the following code:

```matlab
Ibpad = padarray(Ib, [10, 50]);
Ibcrop = imcrop(Ib, [250, 50, 120, 300]);
subplot(2,2,3), imagesc(Ibpad); title('Padded')
subplot(2,2,4), imagesc(Ibcrop); title('Cropped')
```

Note, for `padarray`, the second argument defines how many rows and columns will be added to the image, while for `imcrop`, the second argument defines the rectangular region that will be taken from the original image, defined as: `[xmin ymin width height]`. 

As with many of the functions introduced in these exercises, these functions have many other possible arguments that modify their behaviour: full details can be obtained by using `help` or the MATLAB online help centre (https://www.mathworks.com/help/index.html).

Sometimes it is convenient to represent an image as a vector rather than as a matrix (i.e. as a "vectorised" image). If `I` is an image in matrix form, `Iv = I(:);` will create a vector `Iv` whose elements are the columns of `I` appended end-to-end to form one column vector. To return a vector to matrix form, use `reshape`. 

The following code uses these reshaping commands to add a diagonal line to the synthetic image created earlier:

```matlab
Isynv = Isyn(:);
Isynv(1:202:end) = 1;
Isyn = reshape(Isynv, 201, 201);
figure(4), clf, imagesc(Isyn); colormap('gray')
```

---

## Translating Images for Intensity Change Detection

We will start off by converting the elephant image (modified to have a white rectangular region) from `uint8` format to `double` format:

```matlab
Ibd = im2double(Ib);
```

This is done because the following calculations will produce negative numbers that cannot be represented using unsigned integer values but can be correctly represented using floating-point numbers.

We then calculate the differences in intensity values between pixels that are vertical neighbours. To do this we take all the rows of the image that have a neighbour vertically below them, subtract that neighbour's value, and show the result:

```matlab
Ibdiffv = Ibd(1:end-1, :) - Ibd(2:end, :);
figure(4), clf, imagesc(Ibdiffv); colormap('gray'); colorbar
```

We calculate the differences in intensity values between pixels that are horizontal neighbours, using an analogous method:

```matlab
Ibdiffh = Ibd(:, 1:end-1) - Ibd(:, 2:end);
figure(5), clf, imagesc(Ibdiffh); colormap('gray'); colorbar
```

The results are two images in which most pixels have low intensity values (values near zero). The few high-intensity values (positive or negative) that are significantly different from zero occur where neighbouring pixels have different intensity values. We informally refer to these locations as "edges", as they often occur at the boundaries or edges of different objects or surfaces.

Highlighting locations where intensity changes is often performed in computer vision; however, it is typically achieved using alternative techniques to the one used here. These typical techniques will be described in next week's lecture. Specifically, identical results to those produced here can be obtained using horizontal and vertical first-derivative masks, which will be described in next week's lecture.

We can combine the vertical and horizontal difference images into a single image showing (using positive pixel values) large changes in the intensity in both the vertical and horizontal directions, by calculating the L2-norm (or Euclidean

 norm):

```matlab
Ibdiff = sqrt(Ibdiffh(1:end-1, :).^2 + Ibdiffv(:, 1:end-1).^2);
figure(6), clf, imagesc(Ibdiff); colormap('gray'); colorbar
```

We can convert this to a binary image (using one of the conversion methods mentioned in last week's MATLAB exercise), and display it, as follows:

```matlab
bw = im2bw(Ibdiff, 0.075);
figure(7), clf, imagesc(bw); colormap('gray'); colorbar
```

---

## Redundancy in Natural Images

Natural images exhibit a high degree of redundancy, i.e., the similarity between the intensity of a pixel at location `(x, y)` and that at a neighbouring location `(x + o, y)` is high when the distance `o` is small, and the similarity is inversely proportional to the distance `o` between these points.

One metric for assessing similarity is the correlation coefficient, which can be calculated for two equally-sized images (or image patches) using the MATLAB command `corr2`. Execute `help corr2` to find out how the correlation coefficient is calculated.

To calculate the correlation coefficient for the elephant image (modified to have a white rectangular region) with itself, we can use:

```matlab
corr2(Ib, Ib)
```

In the previous section, we subtracted an image from a copy of the same image shifted one pixel vertically. Using this technique, calculate the similarity (measured using the correlation coefficient) for the modified elephant image and the same image shifted one pixel vertically. 

Write a simple MATLAB function or script that will automate the process of calculating the correlation coefficient between overlapping parts of the same image shifted vertically by different values. Ensure that the two image parts are as large as possible. Using this code, calculate the correlation coefficient for values of shifts between 0 and 30 pixels for both the elephant image (modified to have a white rectangular region) and the woods image. Plot a graph of correlation coefficient vs. shift for both the elephant and the woods image.

---

## Retinal Ganglion Cells (Simulated with Difference of Gaussians)

To simulate a retinal ganglion cell, we use a Difference of Gaussians (DoG) mask (or operator). To produce a DoG mask we can use the MATLAB command `fspecial` to create two Gaussian masks that are subtracted from each other. Use the following code to generate an on-centre, off-surround DoG:

```matlab
dog = fspecial('gaussian', 11, 1.25) - fspecial('gaussian', 11, 1.75);
```

To simulate the response of retinal ganglion cells to all different parts of an image, we can convolve the DoG mask with the image (the details of convolution will be explained in the next week's lecture, but you can complete the current exercise without knowing these details). To simulate the responses of on-centre, off-surround retinal ganglion cells to all different parts of the modified elephant image, execute the following:

```matlab
Ibdog = conv2(Ibd, dog, 'same');
```

Note, use `Ibd`: the version of the elephant image (modified to have a white rectangular region) that was converted to double format earlier in this exercise.

Take a look at this result, by showing the image created:

```matlab
figure, clf, imagesc(Ibdog); colormap('gray'); colorbar
```

---

## Colour Opponent Cells

The type of retinal ganglion cell simulated in the previous section processes intensity. In this section, a different type of retinal ganglion cell, colour opponent cells, will be simulated.

In the previous section, we created the DoG (by subtracting one Gaussian from another) and then convolved this with the image. It would have been possible to produce an identical result by convolving the image twice with two different Gaussian masks, and taking the difference between the two outputs of these convolutions. This latter approach is used to simulate colour opponent cells, except each Gaussian is convolved with a different colour channel of a colour image.

We will apply this technique to the rooster image, which is an RGB colour image, after conversion from `uint8` to `double` format, i.e., using `Iad = im2double(Ia);`.

First, create two Gaussians to simulate the centre and surround of the cell's receptive field (RF):

```matlab
gc = fspecial('gaussian', 9, 1);
gs = fspecial('gaussian', 9, 1.5);
```

You can then simulate the response of a red-on, green-off colour opponent cell by executing:

```matlab
IaRG = conv2(Iad(:,:,1), gc, 'same') - conv2(Iad(:,:,2), gs, 'same');
```

Note: Colour channels are the third dimension of `Iad` and channel 1 is the red channel, and channel 2 is the green channel.

Generate an image with 4 subplots, with the subplots showing the response of the following centre-surround colour opponent cell combinations on the rooster image:

1. Red-on, green-off
2. Green-on, red-off
3. Blue-on, yellow-off
4. Yellow-on, blue-off

Note: An RGB image does not have a yellow channel, but you can create one by calculating the mean of the red and green channels, using:

```matlab
mean(Iad(:,:,1:2), 3)
```

---

## Lab Format for Colour Images

Looking at the results for the previous section, you should also notice that the outputs of the different colour-opponent cells are redundant. Specifically, `(red-on, green-off) ≈ -(green-on, red-off)` and `(blue-on, yellow-off) ≈ -(yellow-on, blue-off)`. The different types of red/green colour-opponent cells essentially represent the same information, as do the various types of blue/yellow opponent cells. As we will see in this section, the Lab image format represents colour in a similar way.

RGB images represent each pixel in a 3-dimensional feature-space, where the three feature axes are:

1. The intensity of red
2. The intensity of green
3. The intensity of blue

This is similar to the way that the cone photoreceptors in the human eye represent the image.

Lab images also represent each pixel as a point in a 3-dimensional feature space; however, in this case, the three axes are:

1. Light-dark
2. Red-green
3. Blue-yellow

This is similar to the way that rod photoreceptors and colour opponent cells in the retina represent the image.

To compare the Lab image format with the colour-opponent results produced in the previous section, do the following (replacing `IaRG` and `IaYB` with the variable names you used for the outputs produced by the red-on, green-off and yellow-on, blue-off colour-opponent cells in the previous section):

```matlab
figure(10), clf, colormap('gray')
Iagray = rgb2gray(Iad);
subplot(2,3,1); imagesc(Iagray); axis('off', 'equal', 'tight'); colorbar, title('intensity')
subplot(2,3,2); imagesc(IaRG); axis('off', 'equal', 'tight'); colorbar, title('red-on, green-off');
subplot(2,3,3); imagesc(IaYB); axis('off', 'equal', 'tight'); colorbar, title('yellow-on, blue-off');
Ialab = rgb2lab(Iad);
subplot(2,3,4); imagesc(Ialab(:,:,1)); axis('off', 'equal', 'tight'); colorbar, title('L-channel');
subplot(2,3,5); imagesc(Ialab(:,:,2)); axis('off', 'equal', 'tight'); colorbar, title('a-channel');
subplot(2,3,6); imagesc(Ialab(:,:,3)); axis('off', 'equal', 'tight'); colorbar, title('b-channel');
```