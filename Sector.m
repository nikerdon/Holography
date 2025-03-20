clc;
close all;
clear all;
global x0 y0 w h 

%im = double(rgb2gray(imread('clear7.png')));
im = double(imread('blank.png'));

[h,w] = size(im);

I1c=im(1:2:h,1:2:w); % фаза 3pi/2
I2c=im(1:2:h,2:2:w); % фаза pi
I3c=im(2:2:h,1:2:w); % фаза 0
I4c=im(2:2:h,2:2:w); % фаза pi/2

Hc=(I3c-I2c)+1i*(I4c-I1c); % матрица интерферирующих волн
%phi = angle(Hc);
phi = Hc;

x0 = 437;
y0 = 293;

hold on
imshow(angle(phi),[-pi pi])
line([x0 x0],[y0 y0],'Color','green','Marker','*')
line([1 w/2],[y0 y0],'Color','red')

theta = pi/2;
angle_line(theta)
hold off

mask = zeros(h/2,w/2);

for l=(x0+1):w/2
    for i=1:y0
        for j=x0:w/2
            if round(sqrt((j-x0)^2 + (i-y0)^2)) == abs(l-x0) && (y0-i)/(j-x0) <= tan(theta)
               mask(i,j) = l;
            end
        end
    end
end

n = 1;
circ = zeros(w/2-x0);
for u=(x0+1):w/2
    [r,c] = find(mask==u);
    rc = [r c];
    m(n) = size(rc,1);
    for t=1:m(n)
        circ(n) = circ(n) + phi(rc(t,1),rc(t,2));
    end
    circ(n) = circ(n)/m(n);
    n = n+1;
end
x = linspace(x0+1,w/2,w/2-x0);
figure,subplot(2,1,1),plot(x,circ(:,1))

% f = abs(log(1+fftshift(fft(circ(:,1)))));
% f(x > 900) = 0;
% subplot(2,1,2),plot(x,f)

filt = zeros(h/2,w/2);
for l=(x0+1):w/2
    for i=1:h/2
        for j=1:w/2
            if round(sqrt((j-x0)^2 + (i-y0)^2)) == abs(l-x0)
               filt(i,j) = circ(l-x0,1);
            end
        end
    end
end
figure,imshow(angle(filt),[-pi pi])

figure,imshow(angle(phi-filt),[-pi pi])

function output = angle_line(theta)
global x0 y0 w h 
test = 0;
for i=1:y0
    for j=x0:w/2
        if (y0-i)/(j-x0) <= tan(theta)
            line([x0 j],[y0 i],'Color','red')
            test = 1;
            break
        end
    end
    if test == 1
        break
    end
end
end
