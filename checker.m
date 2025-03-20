clc;
close all;
clear all;

% im1 = readmatrix('Blank no para.txt');
% im2 = readmatrix('clear7 no para.txt');

im1 = readmatrix('Blank no para fft.txt');
im2 = readmatrix('clear7 no para fft.txt');

a1 = angle(im1);
a2 = angle(im2);

imshow(a1,[-pi,pi])
figure,imshow(a2,[-pi,pi])

Fc = angle(exp(1i*(a1-a2)));

figure,imshow(Fc,[-pi,pi])


