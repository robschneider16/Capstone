


camera = webcam;
tempstring = camera.resolution;
figure;
disp('Initializing Camera Brightness'); 
for i=1:300
    %get RGB image from webcam to init camera aperature and levels
    RGBtest = snapshot(camera);
    imshow(RGBtest);
end

disp('Aquiring image of object'); 
ObjectImage = snapshot(camera);



%get user to crop image so it is just the object it wants to recognize,
%crop or select points that user wants to delete. 

%get user to name to object, to save variable as what its named, for future
% addition of key points of the same object for better recognition and
% tracing.


%for now, just do the following, create gui for adding new objects to
%representation. Machine Learning integration to weighting key points by
%how much they appear?! 
%Loading image from precaptured and edited jpg
%ObjectImage = imread('Object.jpg');

ObjectSURFPoints = detectSURFFeatures(rgb2gray(ObjectImage));
[ObjectSURFFeatures, ObjectSURFPoints] = extractFeatures(rgb2gray(ObjectImage), ObjectSURFPoints);

ObjectBRISKPoints = detectBRISKFeatures(rgb2gray(ObjectImage),'MinContrast', .2);
[ObjectBRISKFeatures, ObjectBRISKPoints] = extractFeatures(rgb2gray(ObjectImage), ObjectBRISKPoints);

imshow(ObjectImage);
title('Image of Object with Strongest features located');
hold on;
plot(selectStrongest(ObjectBRISKPoints, 150));

save('MemoryOfLearnedObjects','ObjectImage','ObjectBRISKFeatures', 'ObjectBRISKPoints', 'ObjectSURFFeatures', 'ObjectSURFPoints');
