load('MemoryOfLearnedObjects');
%loads 'ObjectImage','ObjectBRISKFeatures', 'ObjectBRISKPoints', 'ObjectSURFFeatures', 'ObjectSURFPoints'
%so far.


camera = webcam('Microsoft® LifeCam Cinema(TM)');
tempstring = camera.resolution;
disp('Initializing Camera Brightness'); 

figure;
for i=1:50
    %get RGB image from webcam to init camera aperature and levels
    RGBtest = snapshot(camera);
    imshow(RGBtest);
end

disp('Aquiring image and features of the Scene'); 

%loop 
for i=1:100
    SceneImage = snapshot(camera);
    hold off;
    imshow(SceneImage);
try
    SceneSURFPoints = detectSURFFeatures(rgb2gray(SceneImage));
    [SceneSURFFeatures, SceneSURFPoints] = extractFeatures(rgb2gray(SceneImage), SceneSURFPoints);
    %imshow(SceneImage);
    %title('300 Strongest Feature Points from Scene Image');
    %hold on;
    %plot(selectStrongest(ScenePoints, 300));


    SceneBRISKPoints = detectBRISKFeatures(rgb2gray(SceneImage),'MinContrast', 0.2);
    [SceneBRISKFeatures, SceneBRISKPoints] = extractFeatures(rgb2gray(SceneImage), SceneBRISKPoints);



    BRISKPairs = matchFeatures(ObjectBRISKFeatures, SceneBRISKFeatures);
    SURFPairs = matchFeatures(ObjectSURFFeatures, SceneSURFFeatures);
    
    
    matchedObjectBRISKPoints = ObjectBRISKPoints(BRISKPairs(:, 1),:);
    matchedSceneBRISKPoints = SceneBRISKPoints(BRISKPairs(:, 2),:);
    
    matchedObjectSURFPoints = ObjectSURFPoints(SURFPairs(:, 1),:);
    matchedSceneSURFPoints = SceneSURFPoints(SURFPairs(:, 2),:);

    matchedCombinedObject = [matchedObjectSURFPoints.Location; matchedObjectBRISKPoints.Location];
    matchedCombinedScene = [matchedSceneSURFPoints.Location; matchedSceneBRISKPoints.Location];
    
    %showMatchedFeatures(ObjectImage, SceneImage, matchedCombinedObject, matchedCombinedScene, 'montage');
    %title('Putatively Matched Points (Including Outliers)');


    [tform, inlierObjectPoints, inlierScenePoints] = estimateGeometricTransform(matchedObjectSURFPoints, matchedSceneSURFPoints, 'affine');

    %showMatchedFeatures(ObjectImage, SceneImage, inlierObjectPoints, inlierScenePoints, 'montage');
    %title('Matched Points (Inliers Only)');
   

    Polygon = [1, 1;...                           % top-left
            size(ObjectImage, 2), 1;...                 % top-right
            size(ObjectImage, 2), size(ObjectImage, 1);... % bottom-right
            1, size(ObjectImage, 1);...                 % bottom-left
            1, 1];                   % top-left again to close the polygon
    ObjectPolygon = transformPointsForward(tform, Polygon);
    hold on;
    line(ObjectPolygon(:, 1), ObjectPolygon(:, 2), 'Color', 'y');
    %plot(SceneSURFPoints);
    pause(1);
   
catch err
    
end

hold off

end
    
    
clear

