clc
clear all
close all

im = double(imread('grp9_2.bmp'));
im = double(imread('clear2.bmp'));

[h,w] = size(im);

I1c=im(1:2:h,1:2:w); % фаза 3pi/2
I2c=im(1:2:h,2:2:w); % фаза pi
I3c=im(2:2:h,1:2:w); % фаза 0
I4c=im(2:2:h,2:2:w); % фаза pi/2

Hc=(I3c-I2c)+1i*(I4c-I1c); % матрица интерферирующих волн
%phi = angle(Hc);
im = Hc;

%figure,imshow(im,[-pi,pi])
im_fft = fftshift(fft2(im));
im_fft1 = im_fft;

figure,imshow(log(abs(im_fft)),[]);

for i=1:1224-950
    im_fft(:,951)=[];
end
for i=1:860
    im_fft(:,1)=[];
end


figure,plot(medfilt1(sum(abs(im_fft).^2,2),20))
xlim([0 h/2])
view(90, 90)
figure,imshow(log(abs(im_fft)),[]);

for j=1:1024-310
    im_fft1(311,:)=[];
end
for j=1:275
    im_fft1(1,:)=[];
end
figure,plot(medfilt1(sum(abs(im_fft1).^2,1),20))
xlim([0 w/2])
figure,imshow(log(abs(im_fft1)),[]);