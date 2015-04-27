%calibrate one camera
cameraL = webcam(2);
cameraR = webcam(3);

numImagePairs = 21;
calibrationFilesL = zeros(1024,1280,3,numImagePairs);
calibrationFilesR = zeros(1024,1280,3,numImagePairs);
figure;
for i=1:100
    %get RGB image from webcam to init camera aperature and levels
    L = snapshot(cameraL);
    R = snapshot(cameraR);
    imshow(cat(3, L(:,:,1), R(:,:,2:3)), 'InitialMagnification', 50);
end
pause(3);
for i=1:numImagePairs
% Try to detect the checkerboard
L = snapshot(cameraL);
R = snapshot(cameraR);
calibrationFilesR(:,:,:,i) = R(:,:,:);
calibrationFilesL(:,:,:,i) = L(:,:,:);
imshow(cat(3, L(:,:,1), R(:,:,2:3)), 'InitialMagnification', 50);
imwrite(L, strcat('Images/ImageL', num2str(i), '.jpg'));
imwrite(R, strcat('Images/ImageR', num2str(i), '.jpg'));
pause(5);
end
