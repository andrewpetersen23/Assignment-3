clc; clear; clear all;

Irgb = imread('rotor10.jpg');
Ihsv = rgb2hsv(Irgb);
I = Ihsv(:,:,3);

BW1 = edge(I,'canny', [.05 .5]);
% imshow(BW);

SE1 = strel('line',7, 0);
SE2 = strel('line',3, 90);
dial = imdilate(BW1,[SE1 SE2]);
% imshow(dial);

BW2 = imfill(dial,'holes');
imshow(BW2);

stats = regionprops('table',BW2,'Centroid',...
    'MajorAxisLength','MinorAxisLength');
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = stats.MajorAxisLength/2;
hold on
viscircles(centers,radii);
hold off

totPix = pi * (radii(1)^2);
x = sum(BW2);
bladePix = sum(x);
gapPix = totPix - bladePix;
ratio = gapPix/bladePix