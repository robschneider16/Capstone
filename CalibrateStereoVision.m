clear
numImagePairs = 21;
calibrationFilesL = zeros(1024,1280,3,numImagePairs);
calibrationFilesR = zeros(1024,1280,3,numImagePairs);
cfL = zeros(1024,1280,numImagePairs);
cfR = zeros(1024,1280,numImagePairs);

figure;
for i=1:numImagePairs
% Try to detect the checkerboard
L = imread(strcat('Images/ImageL', num2str(i), '.jpg'));
R = imread(strcat('Images/ImageR', num2str(i), '.jpg'));
calibrationFilesL(:,:,:,i) = L;
calibrationFilesR(:,:,:,i) = R;
cfL(:,:,i) = rgb2gray(L);
cfR(:,:,i) = rgb2gray(R);
imshow(cat(3, L(:,:,1), R(:,:,2:3)), 'InitialMagnification', 50);
end
    
disp('Calibrating Stereo Cameras from detected Checkerboard points'); 
[imagePoints, boardSize, idx] = detectCheckerboardPoints(calibrationFilesL, calibrationFilesR);
disp('finished checkerboard detection and matching'); 
% Display the image with the incorrectly detected checkerboard
%subplot(2,1,1);
%imshow(imageFiles1(:,:,:,i), 'InitialMagnification', 50);
%hold on;
%plot(imagePoints(:, 1,1,1), imagePoints(:, 2,1,1), '*-g');
%title('Checkerboard Detection for Camera Calibration');
%hold off;
%subplot(2,1,2);
%imshow(imageFiles2(:,:,:,i), 'InitialMagnification', 50);
%hold on;
%plot(imagePoints(:, 1,1,1), imagePoints(:, 2,1,1), '*-g');
%title('Checkerboard Detection for Camera Calibration');
%hold off;

% Generate world coordinates of the checkerboard points.
squareSize = 24; % millimeters
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Compute the stereo camera parameters.
stereoParams = estimateCameraParameters(imagePoints, worldPoints);

% Evaluate calibration accuracy.
showReprojectionErrors(stereoParams);

save('Calibration', 'stereoParams', 'boardSize', 'idx');

