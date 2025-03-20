clc;
close all;
clear all;

phi1 = readmatrix('Blank no para.txt');
h = size(phi1,1);
w = size(phi1,2);

%figure,imshow(abs(log(fftshift(fft2(phi1))+1)),[])

phi1_fft1 = fftshift(fft2(phi1));
phi1_fft = fftshift(fft2(phi1));
%phi1_fft(and(1:h >= 350, 1:h <= 570),and(1:w >= 400,1:w <= 720)) = 0;
phi1_fft(:,or(1:w <= 500,1:w >= 700)) = 0;
phi1_fft(or(1:h <= 440, 1:h >= 600),:) = 0;
%phi1_fft(or(1:h >= 530, 1:h <= 490),or(1:w <= 590,1:w >= 620)) = 0;
figure,imshow(abs(log(phi1_fft+1)),[])
filt_four = angle(ifft2(ifftshift(phi1_fft)));
figure,imshow(filt_four,[-pi pi])
%figure,imshow(angle(phi1),[-pi pi])
x = [1 w];
y = [290 290];
figure
c1 = improfile(filt_four,x,y);
plot(c1)


