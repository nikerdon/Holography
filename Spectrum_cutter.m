clc;
close all;
clear all;

%im = readmatrix('Blank no para.txt');
%im = readmatrix('clear7 no para.txt');
%im = double(rgb2gray(imread('clear7.png')));
%im = double(imread('blank.png'));
%im = double(rgb2gray(imread('clear7.png')));
im = double(imread('grp9_2.bmp'));
im0 = double(imread('clear2.bmp'));
%im = double(imread('angle no para grp9_2.bmp'));
mask = readmatrix('mask.txt');

fon = readmatrix('fon1.txt');

[h,w] = size(im);

lambda = 532e-9;
px = 2*3.45e-6;

w = 2448;
h = 2048;

for t=103:103
Rx = pi * (px * w/2)^2 / lambda / 156 / 4.96;
Ry = pi * (px * h/2)^2 / lambda / t / 4.96; 

[X1, X2] = meshgrid(1:w/2, 1:h/2);

a = exp(-1i*pi/lambda*px^2*((X1-w/4).^2/Rx+(X2-h/4).^2/Ry));

I1c=im(1:2:h,1:2:w); % фаза 3pi/2
I2c=im(1:2:h,2:2:w); % фаза pi
I3c=im(2:2:h,1:2:w); % фаза 0
I4c=im(2:2:h,2:2:w); % фаза pi/2


I1c0=im0(1:2:h,1:2:w); % фаза 3pi/2
I2c0=im0(1:2:h,2:2:w); % фаза pi
I3c0=im0(2:2:h,1:2:w); % фаза 0
I4c0=im0(2:2:h,2:2:w); % фаза pi/2

Hc=(I3c-I2c)+1i*(I4c-I1c); % матрица интерферирующих волн
%Hc=readmatrix("angle no para grp9_2.txt");
%Hc0 = readmatrix("angle no para clear2.txt");
Hc0 = (I3c0-I2c0)+1i*(I4c0-I1c0);

phi = Hc;
im = phi;
figure,imshow(im,[-pi,pi])
%im_fft = fftshift(fft2(im));
im_fft = fftshift(fft2(Hc.*a));
im_fft0 = fftshift(fft2(Hc0.*a));
figure,imshow(log(abs(im_fft)),[]);

hh = impoly;
mask = createMask(hh);
maskedMatrix = im_fft .* mask;
maskedMatrix0 = im_fft0 .* mask;

for j=2:2
% maskedMatrix1 = zeros(h/2,w/2);
% 
% [m, linearIndex] = max(maskedMatrix(:));
% [row, col] = ind2sub(size(maskedMatrix), linearIndex-1);
% 
% maskedMatrix1(1+(h/4-row+j):h/4+(h/4-row+j),w/4-(col-w/4-1):w/2-(col-w/4-1)) = maskedMatrix(1:h/4,w/4:w/2);
% 
% figure,imshow(abs(log(1+maskedMatrix1)),[]);

filt_four = ifft2(ifftshift(maskedMatrix));
filt_four0 = ifft2(ifftshift(maskedMatrix0));
figure,imshow(-angle(filt_four./ exp(1i*angle(fon))),[-pi pi])
figure,imshow(-angle(filt_four./ exp(1i*angle(filt_four0))),[-pi pi])
%title(num2str(t))
figure,imshow(log(abs(fftshift(fft2(filt_four)))),[])
    end
end