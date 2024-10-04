## General Information
This coursework is formative, meaning that it is designed to facilitate learning, not to assess what you know. This means that the mark you obtain in this exercise does **NOT** contribute to your final mark for the module: the mark you achieve is purely to help you gauge how well you have understood and can apply the methods you have been taught.

This exercise will allow you to apply knowledge gained in lectures and tutorials to more practical problems using more realistic data, and hence, help consolidate and expand your knowledge. It will also allow you to develop coding skills that will be needed to complete the assessed coursework.

If you need clarification on the instructions or other help, then please ask: the KEATS forum is the best place to do this. Alternatively, you can submit arbitrary answers and you will then be able to see an explanation of what you should have done to get the correct answer, or at the minimum be told the correct answer so that you can work backwards to determine how you should be obtained this answer. Any suggestions as to how to make the instructions clearer are also most welcome.

You do not need to complete this exercise in one go. You can leave KEATS and return at a later time and continue from where you left off.

### Decimal Precision
For numerical values that are non-integer real numbers, provide answers correct to at least **2 decimal places**, which means that calculations should be performed with a precision of at least **4 decimal places**. 

Example:

- If the correct answer is `5.2689`, these answers are correct: `5.2689`, `5.269`, `5.27`. 
- These answers would be incorrect: `5.26` (incorrect rounding), `5.2`, `5.3` (insufficient decimal places).

The decimal point **must** be a period (`.`), not a comma (`,`). Do **NOT** enter white-space characters in the answer boxes.

---

## Introduction
This exercise provides an introduction to working with images in MATLAB.

### Requirements
- Access to MATLAB (instructions for running MATLAB are available on the module's KEATS webpage).
- Familiarity with the MATLAB interface and programming language (links to general introductory MATLAB tutorials are available on the module's KEATS webpage).

You will also need access to the module's KEATS webpage to download some images that will be used later in this, and subsequent, MATLAB exercises.

Note that commands which you can type at the MATLAB prompt are indicated by text in the following typeface:

```matlab
matlab_function(parameter1, parameter2);
```

You can use MATLAB interactively by typing commands at the prompt. You can also write MATLAB functions by creating m-files (text files containing user-defined MATLAB functions). You can also write MATLAB scripts, which are m-files that just contain a sequence of MATLAB commands. As with built-in MATLAB functions, user-written functions and scripts can be executed by typing the name of the m-file at the MATLAB prompt (assuming the directory containing the m-file is on your path).

For this and subsequent MATLAB exercises, it is recommended that you write a MATLAB script file containing all your work, so that you can easily save your work and return to it at a later time.

To obtain information on any in-built MATLAB function, just type:

```matlab
help function_name
```

at the MATLAB prompt (replacing `"function_name"` with the name of the function you want to know about). Alternatively, search for the function in the MATLAB online help centre: [MATLAB Help](https://www.mathworks.com/help/index.html).

---

## Common Pitfalls when Working with Images in MATLAB
### Semicolon Usage
Be sure not to forget the semicolon at the end of a command. Otherwise, you may sit for a while watching all the values from a large variable (such as an image) scroll by on the screen.

To illustrate:

```matlab
I1 = rand(1000,1000)
I2 = rand(1000,1000);
```

- The first command (without the semicolon) prints lots of numbers to the screen, while the second command (with the semicolon) does not.

### MATLAB Loops
MATLAB is painfully slow at executing loops, so only use them when absolutely necessary. Instead, write commands that perform operations on whole vectors or matrices in one go, rather than using loops to perform the same operation on each element one at a time.

For example, to add together the values in the two random matrices you just created, you might be tempted to use nested for-loops:

```matlab
for i=1:1000
   for j=1:1000
     Isum(i,j) = I1(i,j) + I2(i,j);
   end
end
```

However, it is much better (both in terms of code clarity and computation time) to add two matrices as follows:

```matlab
Isum = I1 + I2;
```

### Element-wise Multiplication
Be sure to use `.*` instead of `*` when you are multiplying two images together element-by-element. Otherwise, MATLAB will perform matrix multiplication, which will generate a meaningless result.

For example:

```matlab
ImultA = I1 * I2;
```

produces results that are very different from:

```matlab
ImultB = I1 .* I2;
```

Similarly, `I^2` is equivalent to `I*I`, whereas `I.^2` is equivalent to `I.*I`. Many other functions have both matrix-wise and element-wise versions.

Note: Addition is an element-wise operation, so it is not necessary to use `.+` (in fact, `.+` is not defined).

---

## Loading Images from Files
A digital image is composed of pixels. An image file contains information about the intensity and/or colour of each pixel. To store information describing all the pixel values in a large image takes a lot of memory, so images are often stored in a compressed format, like JPEG.

To read an image into MATLAB, use the `imread` function:

```matlab
Ia = imread('rooster.jpg');
Ib = imread('elephant.png');
```

## Image Representation

Once an image file has been read, it is stored internally using one of several formats. The most common formats used by MATLAB are:

### Intensity Images

This is equivalent to a "grayscale image". It represents an image as a matrix where every element corresponds to a pixel, and the value stored at each pixel defines how bright/dark the image is at that location.

There are two main ways to store the numbers that represent the intensity values:

- **Double data type**: Assigns a floating-point number in the range `0.0` to `1.0` to each pixel. The value `0.0` corresponds to black and the value `1.0` corresponds to white.
- **Uint8 data type**: Assigns an integer in the range `0` to `255` to represent the brightness of a pixel. The value `0` corresponds to black and `255` to white.

The class `uint8` requires roughly 1/8 of the storage compared to the class `double`. On the other hand, many mathematical functions can only be applied to the `double` class.

### Binary Images

This image format also stores an image as a matrix but can only represent pixels as black or white (and nothing in between). It uses a `0` for black and a `1` for white.

### RGB Images

This is a common format for colour images. It represents an image using a 3-dimensional matrix. The third dimension (sometimes called the colour channels of the image) corresponds to one of the colours red, green, or blue, and the values of the elements specify the intensity of the corresponding colour at each pixel. As with intensity images, values may be specified as floating-point numbers or as integer values.

### Indexed Images

An indexed image stores an image using two matrices. The first matrix has the same size as the image and contains one number for each pixel. The second matrix is called the colour map, and its size may be different from the image. Each of the numbers in the first matrix is an instruction of what number to use from the colour map matrix to define the pixel's colour.

---

If you have been following the instructions so far, you will have a number of variables in memory. You can get information about these variables by looking at the workspace window or by typing `whos` at the MATLAB prompt. If you do that, you should get:

```
  Name           Size                 Bytes  Class     Attributes 

  I1          1000x1000             8000000  double               
  I2          1000x1000             8000000  double               
  Ia           341x386x3             394878  uint8                
  Ib           512x512               262144  uint8                
  ImultA      1000x1000             8000000  double               
  ImultB      1000x1000             8000000  double               
  Isum        1000x1000             8000000  double  
```

You will see that `Ia` (the MATLAB variable representing the rooster image) is a 341-by-386 pixel RGB image (or equivalently a 3-dimensional matrix), with values represented using `uint8` format. `Ib` (the MATLAB variable representing the elephant image) is a 512-by-512 pixel grayscale image (or equivalently a 2-dimensional matrix), with pixel values stored using `uint8` format. The random matrices you produced, and the other matrices derived from them (i.e., `I1`, `I2`, `Isum`, `ImultA`, `ImultB`) are 1000-by-1000 element 2-dimensional matrices, with values stored using the `double` format. You can think of these as synthetic, grayscale images.

---

## Image Display

MATLAB provides a number of different commands for displaying an image on the screen: `imshow`, `image`, and `imagesc`. However, in general, `imagesc` is nearly always the most appropriate. So use this in the current, and subsequent, exercises.

These commands display an image using a colormap which describes the mapping between the numbers in the matrix encoding the image and the colours displayed on the screen. To see how numbers map onto colours use the command `colorbar`. To change the colormap, we can use the command `colormap`.

You can display multiple images by either creating multiple figures with the `figure` command or by putting multiple images in the same figure with the `subplot` command.

You can label each plot or subplot using the `title` command.

To illustrate how these commands work, at the MATLAB prompt execute the following:

```matlab
figure(1), subplot(2,2,1), imagesc(Ia); title('RGB image');
```

This displays the image of the rooster which you read from a file earlier.

Now execute:

```matlab
subplot(2,2,2), imagesc(Ia(:,:,1)); title('red channel'); colorbar
subplot(2,2,3), imagesc(Ia(:,:,2)); title('green channel'); colorbar
subplot(2,2,4), imagesc(Ia(:,:,3)); title('blue channel'); colorbar
```

This displays the intensities of the individual R, G, and B channels that make up the image. You will notice that the rooster's crest and neck feathers have high intensity in the red channel, while the grass has high intensity in the green channel.

At the MATLAB prompt, execute the following command:

```matlab
colormap('gray')
```

This will change the colours used to represent the intensity values in the red, green, and blue channels. Note also that the top-left image is unaffected by the choice of colormap, as it is a colour image displayed in true colour.

At the MATLAB prompt, execute the following commands:

```matlab
figure(2), imagesc(Ib); colorbar
```

This displays the elephant image. The colour map shows dark pixels as blue and light pixels as yellow. To display the image in grayscale, change the colormap to gray by executing the command:

```matlab
colormap('gray');
```

Another useful command when displaying images is the `axis` command; this allows you to control the range of pixels that are displayed, the scaling applied to the x- and y-axes, and the appearance of the axes. For example, at the MATLAB prompt, execute the following commands:

```matlab
figure(2), axis('off')
axis('equal')
```

This removes the numbers labelling the axes and reshapes the image so that both the x- and y-axes are scaled equally (this is a square image, 512x512 pixels, so it is now displayed square).

---

## Reading Values From an Image

As seen in the previous section, one way to examine the pixel values in an image is to use `imagesc` to show (a single channel of) the image on the screen, and `colorbar` to show a scale that can be used to read off the approximate values.

To see the raw numerical values, you could just type the name of the variable at the MATLAB prompt (without a trailing semicolon), e.g.:

```matlab
Ib
```

This will show the contents of the variable, but if the variable is an image (Ib is the elephant image) it is likely to produce many values that will be difficult to interpret.

It is possible to be more selective about what values are shown on the screen. For example, execute:

```matlab
Ib(3,:)
```

This will show all the pixel values in the 3rd row of the elephant image.

```matlab
Ib(:,3)
```

This will show all the pixel values in the 3rd column of the elephant image.

```matlab
Ib(1:6,1:4)
```

This displays the numerical values for a patch of the elephant image in the top-left corner (pixels within the first 6 rows and the first 4 columns).

```matlab
Ia(1:6,1:4,1)
```

This displays the numerical values for a patch of the rooster image in the top-left corner (note that these values are from the 1st channel of the rooster image, the red channel). To see the values in the green channel for the same patch, we use:

```matlab
Ia(1:6,1:4,2)
```

Note that both the elephant image (`Ib`) and the rooster image (`Ia`) have integer pixel values (as discussed earlier in the "Image Representation" section). Also, that `Ib` is a 2-dimensional matrix (as the elephant image is an intensity or grayscale image), while `Ia` is a 3-dimensional matrix (as the rooster image is a colour, RGB, image).

MATLAB treats images as matrices. Values in matrices are indexed using `(row, column)` coordinates. Hence, to obtain the value at row 3 and column 4 of the elephant image, you would use:

```matlab
Ib(3,4)
```

However, you should be aware that in computer vision (and in the lectures and tutorials) we index images using `(x, y)` coordinates; this will be discussed in Lecture 2.

---

## Image Conversion

As discussed earlier in the "Image Representation" section, there are a number of different ways of representing images. MATLAB provides commands to convert images from one format to another:

| Conversion                                   | MATLAB command |
| -------------------------------------------- | -------------- |
| from RGB format to indexed format            | `rgb2ind()`    |
| from RGB format to intensity format          | `rgb2gray()`   |
| from RGB format to binary format             | `im2bw()`      |
| from indexed format to RGB format            | `ind2rgb()`    |
| from indexed format to intensity format      | `ind2gray()`   |
| from indexed format to binary format         | `im2bw()`      |
| from intensity format to indexed format      | `gray2ind()`   |
| from intensity format to binary format       | `im2bw()`      |
| from a matrix to intensity format by scaling | `mat2gray()`   |
| from `uint8` to `double` data type           | `im2double()`  |
| from `double` to `uint8` data type           | `im2uint8()`   |
| from RGB to HSV format                       | `rgb2hsv()`    |
| from RGB to Lab format                       | `rgb2lab()`    |

Note that HSV and Lab (see last two rows of the above table) are alternative formats for representing colour images.


---

## Saving Images and Variables to Files

Earlier you learnt how to read an image file into MATLAB. You can also save a MATLAB image as a file. This can be achieved using the `imwrite` command. This command takes three arguments. The first specifies the name of the MATLAB variable that contains the image you wish to store, the second contains the name of the file you wish to store the image in, and the third specifies the file format you wish to use. For example:

```matlab
imwrite(Iagd, 'rooster_gray.jpg', 'jpg')
```

will save, as a JPEG file, the grayscale version of the rooster image you created in the previous section.

Alternatively, you might want to save a MATLAB figure window (with the axes labels, figure title, etc.) as an image. This can be done using the MATLAB `print` command. You execute this command having selected the figure you wish to save, either by using the mouse or by using the `figure` command. For example:

```matlab
figure(1)
print -dpdf rooster_RGB.pdf
```

will produce a PDF file with the four subplots of the rooster image and its colour channels you produced earlier. By typing `help print` you can find out how to produce figures in other formats.

Alternatively, you might want to save the variables in your current MATLAB session so that you can continue work with them at a later date. This can be achieved using the `save` command. For example:

```matlab
save('cv_cw1_variables.mat');
```

will produce a file that you can later load using the `load` command to recover all the variables that you currently have in memory.

---