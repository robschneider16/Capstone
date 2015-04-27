
clear
camera1 = webcam('Microsoft® LifeCam Cinema(TM) #5');
camera2 = webcam('Microsoft® LifeCam Cinema(TM) #6');

numImagePairs = 21;
calibrationFiles1 = zeros(720,1280,3,numImagePairs);
calibrationFiles2 = zeros(720,1280,3,numImagePairs);


for i=1:numImagePairs
% Try to detect the checkerboard
a = snapshot(camera1);
b = snapshot(camera2);
calibrationFiles1(:,:,:,i) = a;
calibrationFiles2(:,:,:,i) = b;
imshow(cat(3, a(:,:,1), b(:,:,2:3)), 'InitialMagnification', 50);

pause(3);
end