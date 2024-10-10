## General Information

This coursework is formative, meaning that it is designed to facilitate learning, not to assess what you know. This means that the mark you obtain in this exercise does **NOT** contribute to your final mark for the module: the mark you achieve is purely to help you gauge how well you have understood and can apply the methods you have been taught. This exercise will allow you to apply knowledge gained in lectures and tutorials to more practical problems using more realistic data, and hence, help consolidate and expand your knowledge. It will also allow you to develop coding skills that will be needed to complete the assessed coursework.

If you need clarification on the instructions or other help, then please ask: the KEATS forum is the best place to do this. Alternatively, you can submit arbitrary answers and you will then be able to see an explanation of what you should have done to get the correct answer, or at the minimum be told the correct answer so that you can work backwards to determine how you should be obtained this answer. Any suggestions as to how to make the instructions clearer are also most welcome.

You do not need to complete this exercise in one go. You can leave KEATS and return at a later time and continue from where you left off.

In general, for numerical values that are non-integer real numbers it is necessary to provide answers correct to at least **2 decimal places**, which means that calculations should be performed with a precision of at least **4 decimal places**. For example, if you are asked to report the answer correct to at least 2 decimal places, and the correct answer is `5.2689` (to 4 decimal places), then all of these answers are correct: `5.2689`, `5.269`, `5.27`. In contrast, the following answers would be incorrect: `5.26` (because this has been rounded to 2 decimal places incorrectly), `5.2`, `5.3` (because these answers do not contain sufficient decimal places). Note, that the decimal point must be a period (`.`) not a comma (`,`). Do **NOT** enter white-space characters in the answer boxes.

---

## Introduction

This exercise provides the opportunity to experiment with some methods of image segmentation.

Remember that commands which you can type at the MATLAB prompt are indicated by text in the following typeface:

```matlab
matlab_function(parameter1, parameter2);
```

In this exercise, you will work with the boat image. Copy the `boat.png` file from the module's KEATS webpage to the directory in which you are running MATLAB, and load this image into MATLAB by using the following commands:

```matlab
I = imread('boat.png');
```

Once you load this image into MATLAB, convert it from `uint8` format to `double` format. Use this converted image throughout the rest of this exercise.

---

## Question 1

### Intensity Histograms

Intensity histograms can sometimes be useful in order to identify thresholds for image segmentation. Plotting a histogram is achieved in MATLAB as follows:

```matlab
hist(v,64);
```

where the first argument is a vector containing the values, and the second argument selects the number of bins in the histogram. To convert an image into a vector, use `v = I(:);` as described in the Resizing and Reshaping Images section of week 2's MATLAB exercise.

Generate an image with four subplots, with the subplots showing:
1) The histogram for the boat's image after conversion to grayscale
2-4) The histograms for each separate color channel of the boat's image. In each case, use 64 histogram bins.

Unlike the example image used in the lecture, the histograms for the boat image do not have two peaks separated by a single valley (although the number of peaks and valleys will depend on the number of histogram bins that are used). We can still try to segment the image using multiple thresholds defined by the position of each valley. Produce a segmented image, where the label `0` signifies all pixels with grayscale intensity `>= 0.68`, the label `1` signifies all pixels with grayscale intensity `< 0.68` but `>= 0.47`, the label `2` signifies all pixels with grayscale intensity `< 0.47` but `>= 0.37`, and label `3` signifies all pixels with grayscale intensity `< 0.37`. These thresholds are roughly the locations of the valleys in the histogram for the grayscale image. Use `imagesc` to display the segmented image.

---

## Morphological Operations

Morphological operations are implemented by the MATLAB commands `imdilate`, `imerode`, `imopen`, and `imclose`. Each of these functions requires two input arguments. The first is an array of pixel values (i.e. an image), and the second is a structuring element that defines the shape of the neighborhood. The structuring element can be defined as an array (for example, `ones(3,3)` defines a 3x3 pixel neighborhood, meaning that each pixel's neighbors are the 8 adjacent pixels horizontally, vertically, and diagonally), or can be defined using a function called `strel` (for example, `strel('disk',2,0)` defines a circular shaped neighborhood of radius 2 pixels).

Morphological operations can be applied to grayscale images, as well as binary ones. To see the effects of applying morphological operations to non-binary images, perform each of the 4 operations listed above on the segmented image (the one produced in the previous section that has integer values `0, 1, 2, and 3` indicating the segmentation labels assigned to each pixel in the boat image through thresholding). Generate an image with 4 subplots, showing these results. Use a 3x3 pixel neighborhood.

---

## k-means Clustering

k-means clustering is implemented by the MATLAB function `imsegkmeans`. To perform 5-means clustering on the RGB values of the boat image, and to see the result, do the following:

```matlab
figure, colormap('default')
Iseg = imsegkmeans(im2single(I),5);
imagesc(Iseg); colorbar; title('k-means Clustering on RGB');
```

Note that `imsegkmeans` requires the data type used for the image to be either integer or single precision: hence, `im2single` is used to change the data type from double- to single-precision.

Determine if including the x- and y-coordinates of each pixel in the feature vectors has a positive or negative effect on the results. You can add additional channels to the image using the function `cat`, and can create arrays containing the x- and y-coordinates using the function `meshgrid`.

---

## Hierarchical Agglomerative Clustering

Hierarchical agglomerative clustering is implemented by the MATLAB function `clusterdata`. This function requires the input data to be in the form of a matrix where each row is a feature vector. Therefore, in order to use it on an image, it is necessary to reshape the image. In addition, because the function uses a lot of memory, it will be necessary to reduce the size of the image before attempting to apply agglomerative clustering. Both reshaping and resizing were covered in week 2's MATLAB exercise. To apply agglomerative clustering to the RGB values of the boat image, do the following preparation steps:

```matlab
Ismall = imresize(I,0.25,'bilinear');
[a,b,c] = size(Ismall);
Msmall = reshape(Ismall,[a*b,c]);
```

To apply hierarchical agglomerative clustering using Euclidean distance and group-average clustering, and using a distance of `0.3` as the distance above which clusters are no longer merged, use the following command:

```matlab
Mseg = clusterdata(Msmall,'cutoff',0.3,'criterion','distance','linkage','average','distance','euclidean');
```

The output produced by `clusterdata` defines the cluster labels of each row of the input. It is therefore necessary to reshape the output back into the shape of the image before viewing the results, as follows:

```matlab
Iseg = reshape(Mseg,[a,b]);
figure, colormap('default');
imagesc(Iseg); colorbar; title('Hierarchical Agglomerative Clustering on RGB');
```

The results produced by the preceding code will display fewer clusters compared to k-means clustering. Apply hierarchical agglomerative clustering to the boat image after the RGB values have been re-scaled so that the values in each color channel range from 0 to 1. Show an image of the result. 
