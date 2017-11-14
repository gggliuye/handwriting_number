
clear all 
close all
clc



imdata = imread('F:\picture\jb.jpg');
imdata = rgb2gray(imdata);
imfft = fft2(imdata);
imifft = ifft2(imfft);
imifft = int8(imifft);
subplot(1,2,1);
imshow(imdata);
subplot(1,2,2);
for i = 1: size(imfft,1)
    for j = 1 : size(imfft,2)
        imfft(i,j) = abs(imfft(i,j))/10000;
    end
end
imshow(imfft);




% 
% % 只保留四个角
% x = size(imdata,1);
% y = size(imdata,2);
% imfft2 = zeros(x,y);
% n = 15;
% q = size(imdata,1) - n + 1;
% p = size(imdata,2) - n + 1;
% kx = [ 1, 1,q, q];
% ky = [ 1, p, 1,p];
% for t = 1 : 4
%     for i = kx(t) :  kx(t) +( n -1)
%         for j = ky(t) :ky(t) + (n -1)
%             imfft2(i,j) = imfft(i,j);
%         end
%     end
% end
% imifft = ifft2(imfft2);
% imifft = int8(imifft);
% subplot(2,2,1);
% imshow(imifft);
% subplot(2,2,2);
% colormap gray;
%  a = colormap;
% imshow(imfft2);
% 
% 
% 
% % 删去四个角
% n = 15;
% q = size(imdata,1) - n + 1;
% p = size(imdata,2) - n + 1;
% kx = [ 1, 1,q, q];
% ky = [ 1, p, 1,p];
% for t = 1 : 4
%     for i = kx(t) :  kx(t) +( n -1)
%         for j = ky(t) :ky(t) + (n -1)
%             imfft(i,j) = 0;
%         end
%     end
% end
% imifft = ifft2(imfft);
% imifft = int8(imifft);
% subplot(2,2,3);
% imshow(imifft);
% subplot(2,2,4);
% imshow(imfft,a);