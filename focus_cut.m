clc;
close all;
clear all;

T = readmatrix("11.txt");
% T(1:920,:) = 0;
% T(1040:2048,:) = 0;
% 
% T(:,1:1020) = 0;
% T(:,1130:1470) = 0;
% T(:,1570:2448) = 0;

T(1:1300,:) = 0;
T(1450:2048,:) = 0;

T(:,1:1030) = 0;
T(:,1570:2448) = 0;

% T(1:1330,:) = 0;
% T(1470:2048,:) = 0;
% T(:,1:1450) = 0;
% T(:,1550:2448) = 0;
imagesc(abs(T))

lambda = 532e-9;
px = 2*3.45e-6/4;
z = 0.0005 * 11;

T = ASL_mex(T, z, lambda, px);
figure,imagesc(abs(T))

im = double(imread('leiko-12202022201359-68.png'));
im = imresize(im,0.25);
[h,w] = size(im);


[h,w] = size(im);

I1c=im(1:2:h,1:2:w); % фаза 3pi/2
I2c=im(1:2:h,2:2:w); % фаза pi
I3c=im(2:2:h,1:2:w); % фаза 0
I4c=im(2:2:h,2:2:w); % фаза pi/2

Hc=(I3c-I2c)+1i*(I4c-I1c); % матрица интерферирующих волн
%zer(1024:3071,1224:3671)
T(1153:2048,:) = [];
T(:,1378:2448) = [];
T(1:896,:) = [];
T(:,1:1071) = [];

figure
subplot(1,2,1),imshow(abs(T),[])
title('abs(T)')
subplot(1,2,2), imshow(angle(T),[])
title('angle(T)')

figure
subplot(1,2,1),imshow(abs(Hc),[])
title('abs(Hc)')
subplot(1,2,2), imshow(angle(Hc),[])
title('angle(Hc)')

figure
subplot(1,2,1), imshow(abs(Hc-T),[])
title('abs(Hc-T)')
subplot(1,2,2), imshow(angle(Hc-T),[])
title('angle(Hc-T)')
