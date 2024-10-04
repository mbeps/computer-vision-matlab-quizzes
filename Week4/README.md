## General Information

This coursework is formative, meaning that it is designed to facilitate learning not to assess what you know. This means that the mark you obtain in this exercise does **NOT** contribute to your final mark for the module: the mark you achieve is purely to help you gauge how well you have understood and can apply the methods you have been taught.

This exercise will allow you to apply knowledge gained in lectures and tutorials to more practical problems using more realistic data, and hence, help consolidate and expand your knowledge. It will also allow you to develop coding skills that will be needed to complete the assessed coursework.

If you need clarification on the instructions or other help, then please ask: the KEATS forum is the best place to do this. Alternatively, you can submit arbitrary answers and you will then be able to see an explanation of what you should have done to get the correct answer, or at the minimum be told the correct answer so that you can work backwards to determine how you should have obtained this answer. Any suggestions as to how to make the instructions clearer are also most welcome.

You do not need to complete this exercise in one go. You can leave KEATS and return at a later time and continue from where you left off.

In general, for numerical values that are non-integer real numbers, it is necessary to provide answers correct to at least **2 decimal places**, which means that calculations should be performed with a precision of at least **4 decimal places**. For example, if you are asked to report the answer correct to at least 2 decimal places, and the correct answer is `5.2689` (to 4 decimal places), then all of these answers are correct: `5.2689`, `5.269`, `5.27`. In contrast, the following answers would be incorrect: `5.26` (because this has been rounded to 2 decimal places incorrectly), `5.2`, `5.3` (because these answers do not contain sufficient decimal places).

Note that the decimal point must be a period (`.`) not a comma (`,`). Do **NOT** enter white-space characters in the answer boxes.

---

## Introduction

This exercise provides the opportunity to experiment with a simple model of low-level biological image processing, as described in this week's lecture. Specifically, you will simulate the responses of V1 orientation-selective cells modelled using Gabor masks. Orientation-selective V1 cells (and Gabor masks) perform edge detection. The current exercise continues from the work in week 2 (biological vision) and week 3 (edge detection).

Remember that commands which you can type at the MATLAB prompt are indicated by text in the following typeface:

```matlab
matlab_function(parameter1, parameter2);
```

In this exercise, you will work with the elephant image. Copy the `elephant.png` file from the module's KEATS webpage to the directory in which you are running MATLAB, and load this image into MATLAB by using the following command:

```matlab
I = imread('elephant.png');
```

Once you load this image into MATLAB, convert it from `uint8` format to `double` format. Use this converted image throughout the rest of this exercise.

You will also need the m-file `gabor2.m` to create Gabor filters. This file is available from the module's KEATS webpage. Copy this m-file into the directory where you are executing MATLAB.

Use the commands:

```matlab
help gabor2
imagesc(gabor2(5,0.2,45,0.5,0))
```

(and variations on the numerical values in the latter command) to discover the effects of the different parameter values.

---

## Simple Cells

A simple model of the response of all V1 simple cells with the same stimulus preferences is provided by convolving an image with a Gabor mask. The parameters of the Gabor mask define the stimulus preference of the simulated V1 simple cells. Particularly, these V1 cells will respond most strongly to intensity discontinuities (i.e. edges) that match the phase and orientation of the Gabor.

To simulate this, convolve the elephant image (using "valid" as the shape parameter in `conv2`) with a Gabor mask generated with the following parameters:

```matlab
gabor2(3,0.1,90,0.75,90);
```

Show an image of the output.

---

## Complex Cells

Combining the outputs of Gabor masks at different phases can be used to detect edges regardless of phase (i.e., with tolerance to the contrast polarity of the intensity discontinuity). Equivalently, this can be considered as a simple model of the responses of all V1 complex cells with the same orientation preference but different RF locations.

To simulate this, convolve (using "valid" as the shape parameter) the elephant image with a second Gabor mask, which has a phase of 0 degrees but is otherwise identical to the mask used in the previous section. These two masks (with 0 and 90 degrees phase) form a quadrature pair.

To combine the two outputs produced by convolving the image with these two masks, calculate the L2-norm of corresponding pixel values (i.e., calculate the square root of the sum of the squared responses of the two simple cells at each image location). 

Show an image of the result.