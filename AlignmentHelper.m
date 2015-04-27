clear
camera1 = webcam(2);
camera2 = webcam(3);


for i=1:1000
    %get RGB image from webcam to init camera aperature and levels
    a = snapshot(camera2);  
    b = snapshot(camera1);
    imshow(cat(3, a(:,:,1), b(:,:,2:3)), 'InitialMagnification', 50);
end
stdisp(a, b);