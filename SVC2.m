clear
camera1 = webcam('Microsoft® LifeCam Cinema(TM) #5');
camera2 = webcam('Microsoft® LifeCam Cinema(TM) #6');

figure;
for i=1:100
    %get RGB image from webcam to init camera aperature and levels
    [b] = snapshot(camera2);
    [a] = snapshot(camera1);
    imshow(cat(3, a(:,:,1), b(:,:,2:3)), 'InitialMagnification', 50);
end



%% Uncalibrated Stereo Image Rectification
% This example shows how to use the |estimateFundamentalMatrix|,
% |estimateUncalibratedRectification|, and |detectSURFFeatures| functions
% to compute the rectification of two uncalibrated images, where the camera
% intrinsics are unknown.
%
% Stereo image rectification projects images onto a common image plane in
% such a way that the corresponding points have the same row coordinates.
% This process is useful for stereo vision, because the 2-D stereo
% correspondence problem is reduced to a 1-D problem. As an example, stereo
% image rectification is often used as a pre-processing step for
% <StereoCalibrationAndSceneReconstructionExample.html computing disparity>
% or creating anaglyph images.
%
%  Copyright 2004-2013 The MathWorks, Inc.

%% Step 1: Read Stereo Image Pair
% Read in two color images of the same scene, which were taken from
% different positions. Then, convert them to grayscale. Colors are not
% required for the matching process.
I1 = rgb2gray(snapshot(camera1));
I2 = rgb2gray(snapshot(camera2));

%%
% There is an obvious offset between the images in orientation and
% position. The goal of rectification is to transform the images, aligning
% them such that corresponding points will appear on the same rows in both
% images.

%% Step 2: Collect Interest Points from Each Image
% The rectification process requires a set of point correspondences between
% the two images. To generate these correspondences, you will collect
% points of interest from both images, and then choose potential matches
% between them. Use |detectSURFFeatures| to find blob-like features in both
% images.
blobs1 = detectSURFFeatures(I1, 'MetricThreshold', 2000);
blobs2 = detectSURFFeatures(I2, 'MetricThreshold', 2000);

%% Step 3: Find Putative Point Correspondences
% Use the |extractFeatures| and |matchFeatures| functions to find putative
% point correspondences. For each blob, compute the SURF feature vectors
% (descriptors).
[features1, validBlobs1] = extractFeatures(I1, blobs1);
[features2, validBlobs2] = extractFeatures(I2, blobs2);

%%
% Use the sum of absolute differences (SAD) metric to determine indices of
% matching features.
indexPairs = matchFeatures(features1, features2, 'Metric', 'SAD', 'MatchThreshold', 5);

%%
% Retrieve locations of matched points for each image
matchedPoints1 = validBlobs1(indexPairs(:,1),:);
matchedPoints2 = validBlobs2(indexPairs(:,2),:);

%%
% Show matching points on top of the composite image, which combines stereo
% images. Notice that most of the matches are correct, but there are still
% some outliers.
figure; showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
legend('Putatively matched points in I1', 'Putatively matched points in I2');
pause(10);
%% Step 4: Remove Outliers Using Epipolar Constraint
% The correctly matched points must satisfy epipolar constraints. This
% means that a point must lie on the epipolar line determined by its
% corresponding point. You will use the |estimateFundamentalMatrix|
% function to compute the fundamental matrix and find the inliers that meet
% the epipolar constraint.
[fMatrix, epipolarInliers, status] = estimateFundamentalMatrix(...
  matchedPoints1, matchedPoints2, 'Method', 'RANSAC', ...
  'NumTrials', 10000, 'DistanceThreshold', 0.1, 'Confidence', 99.99);
  
if status ~= 0 || isEpipoleInImage(fMatrix, size(I1)) ...
  || isEpipoleInImage(fMatrix', size(I2))
  error(['Either not enough matching points were found or '...
         'the epipoles are inside the images. You may need to '...
         'inspect and improve the quality of detected features ',...
         'and/or improve the quality of your images.']);
end

inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

figure; showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
legend('Inlier points in I1', 'Inlier points in I2');
pause(10);
%% Step 5: Rectify Images
% Use the |estimateUncalibratedRectification| function to compute the
% rectification transformations. These can be used to transform the images,
% such that the corresponding points will appear on the same rows.
[t1, t2] = estimateUncalibratedRectification(fMatrix, ...
  inlierPoints1.Location, inlierPoints2.Location, size(I2));
tform1 = projective2d(t1);
tform2 = projective2d(t2);

%%
% Rectify the images using projective transformations, tform1 and tform2.
% Show a color composite of the rectified images demonstrating point
% correspondences.
I1Rect = imwarp(I1, tform1);
I2Rect = imwarp(I2, tform2);

% transform the points to visualize them together with the rectified images
pts1Rect = transformPointsForward(tform1, inlierPoints1.Location);
pts2Rect = transformPointsForward(tform2, inlierPoints2.Location);

figure; showMatchedFeatures(I1Rect, I2Rect, pts1Rect, pts2Rect);
legend('Inlier points in rectified I1', 'Inlier points in rectified I2');
pause(10);
%%
% Crop the overlapping area of the rectified images. You can use red-cyan
% stereo glasses to see the 3D effect.
Irectified = cvexTransformImagePair(I1, tform1, I2, tform2);
figure, imshow(Irectified);
title('Rectified Stereo Images (Red - Left Image, Cyan - Right Image)');
for i=1:100
    %get RGB image from webcam to init camera aperature and levels
    [b] = snapshot(camera2);
    [a] = snapshot(camera1);
    Irectified = cvexTransformImagePair(I1, tform1, I2, tform2);
    imshow(Irectified);
end
pause(10);
%% Step 6: Generalize The Rectification Process
% The parameters used in the above steps have been set to fit the two
% particular stereo images.  To process other images, you can use the
% |cvexRectifyStereoImages| function, which contains additional logic to
% automatically adjust the rectification parameters. The image below shows
% the result of processing a pair of images using this function.

figure,
d = istereo(I1Rect, I1Rect, [20 40], 2);
idisp(d, 'bar');



