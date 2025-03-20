clc;
close all;
clear all;
global h w

%im = double(rgb2gray(imread('clear7.png')));
%im = double(imread('blank.png'));
%im = double(imread('leiko-12202022201359-68.png'));
im = double(imread('grp9_2.bmp'));
%im = double(imread('clear2.bmp'));

%im = imresize(im,0.5);
[h,w] = size(im);
% h1 = 4096;
% w1 = 4896;
% zer = zeros(h1,w1);
% 
% zer(1024:3071,1224:3671) = im;
% %zer(h1/2-h/2:h1/2+h/2-1,w1/2-w/2:w1/2+w/2-1) = im;
% im = zer;
figure, imshow(im,[])

[h,w] = size(im);

I1c=im(1:2:h,1:2:w); % фаза 3pi/2
I2c=im(1:2:h,2:2:w); % фаза pi
I3c=im(2:2:h,1:2:w); % фаза 0
I4c=im(2:2:h,2:2:w); % фаза pi/2

Hc=(I3c-I2c)+1i*(I4c-I1c); % матрица интерферирующих волн

phi = angle(Hc);

% lambda = 532e-9;
% px = 2*3.45e-6;
% T = Hc;
% for i=0.05:0.03:0.60
%     z = 0.01;
%     
%     T = ASL_mex(T, -z, lambda, px);
%     figure,imagesc(abs(T))
%     title(num2str(i))
% end
% finish
%     %subplot(1,2,2),imagesc(angle(T))
%     %title(strcat('Phase',num2str(z)))
%     im_fft = fftshift(fft2(T));
%     figure,imagesc(abs(im_fft));
%     figure,imagesc(angle(im_fft));
%     %M = zeros(w/2,h/2);
%     M = T;
%     for i=287:291
%         for j=431:435
%             M(i,j) = 0;
%         end
%     end
% 
% 
%     M(288,432) = 0;
%     M(289,432) = 0;
%     M(290,432) = 0;
%     
%     M(288,433) = 0;
%     M(289,433) = 0;
%     M(290,433) = 0;
%     
%     M(288,434) = 0;
%     M(289,434) = 0;
%     M(290,434) = 0;
%     M(288,432) = T(288,432);
%     M(289,432) = T(289,432);
%     M(290,432) = T(290,432);
%     
%     M(288,433) = T(288,433);
%     M(289,433) = T(289,433);
%     M(290,433) = T(290,433);
%     
%     M(288,434) = T(288,434);
%     M(289,434) = T(289,434);
%     M(290,434) = T(290,434);
%     figure,imagesc(abs(M));
%     figure,imagesc(abs(ASL_mex(M, z, lambda, px)))
%     figure,imagesc(angle(ASL_mex(M, z, lambda, px)))
% 
%     H1 = Hc .* ASL_mex(M, z, lambda, px);
%     figure,imagesc(angle(H1))
%     H2 = Hc ./ ASL_mex(M, z, lambda, px);
%     figure,imagesc(angle(H2))
% 
%     B=PhaseBlur2(angle(H2),3);
%     figure,imagesc(B)
% %end
% finish

figure, imshow(phi,[])

%imwrite(phi,'phi_clear7.png')

%params0 = [0.0014, 0.0014, 1, 0.01, 0.01];
for i=28.45:28.45
params0 = [0.00015+0.000005*i, 0.00015+0.000005*i];

% Вызов функции lsqnonlin
options = optimoptions('lsqnonlin','Display','iter','Algorithm','levenberg-marquardt','MaxIterations',5); % опциональные параметры
params = lsqnonlin(@(params) para(params, exp(1i*phi)), params0, [], [], options); % вызов функции

% Использование полученных коэффициентов для приближения матрицы
A = params(1);
B = params(2);
%C = params(3);
%D = params(4);
%F = params(5);

[X1, X2] = meshgrid(1:w/2, 1:h/2);
%437 293
%Y = exp(-1i*(A*(X1+502).^2 + B*(X2-1450).^2 + C + D*X1 + F*X2)); % приближенная матрица
Y = exp(-1i*(A*(X1+502).^2 + B*(X2-1450).^2));

%figure, imshow((angle(Y)+pi)/(2*pi))
%figure, imshow(angle(phi./Y))
figure, imshow(angle(exp(1i*(phi-angle(Y)))),[-pi pi])
%title(num2str(i))
end
%filt = exp(1i*(phi))./Y;
%figure,imshow(abs(log(fftshift(fft2(filt))+1)),[])
%writematrix(filt,'Blank no para')

%figure, imshow(angle(exp(1i*(phi))./Y),[-pi pi])
%subplot(2,5,i), imshow(angle(exp(1i*(phi))./Y),[-pi pi])
%figure, imshow(angle(Y),[-pi pi])

function diff = para(params, X)
global h w
    A = params(1);
    B = params(2);
  %  C = params(3);
  %  D = params(4);
  %  F = params(5);

    [X1, X2] = meshgrid(1:w/2, 1:h/2);
    X1 = X1(:);
    X2 = X2(:);
    %Y = exp(-1i*(A*(X1+502).^2 + B*(X2-1450).^2 + C + D*X1 + F*X2));
    Y = exp(-1i*(A*(X1+502).^2 + B*(X2-1450).^2));
    diff = X(:) - Y;
end
