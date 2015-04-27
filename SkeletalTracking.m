clear
CurrentProcess = char('Initializing Variable and Camera');
disp(CurrentProcess); 
format compact
format long

NumOfImages = 1000;
camera = webcam;
tempstring = camera.resolution;

grayImage = zeros(720,1280,NumOfImages); %Declared variables for faster computation.
RGBImage = zeros(720,1280,NumOfImages);
level = zeros(NumOfImages);

set(0,'Units', 'pixels');                   %maybe different units 
screensize = get(0,'ScreenSize');           %get the size of the monitor.
WindowPosition = [1, 1, screensize(3), screensize(4)];   %%window Position
%figure('OuterPosition', WindowPosition);

%initializing Camera Brightness.
%aquires images to auto adjust the
disp('Initializing Camera Brightness'); 
for i=1:100
    %get RGB image from webcam
    RGBtest = snapshot(camera);
    % Convert RGB to grayscale.
end
CurrentProcess = char('Aquiring and rendering images');
disp(CurrentProcess); 
pause(5);
CurrentProcess = char('Aquiring and rendering images');
disp(CurrentProcess); 
for i=1:NumOfImages
    %get RGB image from webcam
    RGBImage = snapshot(camera);
    %subplot(1,3,1)
    imshow(RGBImage);
    % Convert RGB to grayscale.
    %subplot(1,3,2)
    grayImage(:,:,1) = rgb2gray(RGBImage);
    %imshow(grayImage(:,:,i));
    
    %subplot(1,3,3)
    %edgeImage = edge(grayImage(:,:,1));
    %imshow(edgeImage);
    %subplot(1,4,4)
    %{
    [H, Theta, Rho] = hough(edgeImage);
    P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(edgeImage,Theta,Rho,P,'FillGap',5,'MinLength',7);
    hold on
    max_len = 0;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end
    %}
    end
    
    


%show the image
for i=1:NumOfImages
   % level(i) = graythresh(grayImage(:,:,i));
end

    %BinaryImage = im2bw(grayImage(:,:,i), .2);
%imshow(BinaryImage);

