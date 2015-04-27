clear
camera1 = webcam('Microsoft® LifeCam Cinema(TM) #3');
camera2 = webcam('Microsoft® LifeCam Cinema(TM) #4');
load Calibration

figure;

for i=1:1000
    I2 = snapshot(camera1);
    I1 = snapshot(camera2);
    % rectify the setero images to align them in 1 dimension. Crops outliers
    [J1, J2] = rectifyStereoImages(I2, I1, stereoParams); 
    
    %anaglyph image
    imshow(cat(3, J1(:,:,1), J2(:,:,2:3)), 'InitialMagnification', 50);

    %visualize disparities between images.
    disparityMap = disparity(rgb2gray(J1), rgb2gray(J2));
    %imshow(disparityMap, [0, 60], 'InitialMagnification', 50);
end
 