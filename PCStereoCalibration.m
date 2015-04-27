

im1 = imread('Images/ImageL1.jpg');
im2 = imread('Images/ImageR1.jpg');

s1 = isurf(im1);
s2 = isurf(im2);
m = s1.match(s2);