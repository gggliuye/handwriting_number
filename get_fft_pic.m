
clear all 
close all
clc


global num_learn;
num_learn = [489 452 452 453 431 409 452 449 447 422];
global file_name;
file_name = ['F:\france\ES203\ES 203\appr_0.bmp';'F:\france\ES203\ES 203\appr_1.bmp';'F:\france\ES203\ES 203\appr_2.bmp';'F:\france\ES203\ES 203\appr_3.bmp';'F:\france\ES203\ES 203\appr_4.bmp';'F:\france\ES203\ES 203\appr_5.bmp';'F:\france\ES203\ES 203\appr_6.bmp';'F:\france\ES203\ES 203\appr_7.bmp';'F:\france\ES203\ES 203\appr_8.bmp';'F:\france\ES203\ES 203\appr_9.bmp'];

num = sum(num_learn);
%read in files
data = ones(64,64,640,10);
i = 9;
k = 47;


    name = file_name(i,:);
    data(:,:,:,i) = Read_in_data(name);
V = facture(data(:,:,k,i) , 64);
  sizee = 64;
        
  image =  data(:,:,k,i);      
for i = 1 : sizee
    for j = 1 : sizee
        if image(i,j) == 0
            image(i,j) = 1;
        else
            image(i,j) = 0;
        end
    end
end


top = sizee;
left = sizee;
down = sizee;
right = sizee;
for i = 1 : sizee
    for j = 1 : sizee
        if image(i, j) ~= 0
            if top > i 
                top = i;
            end
            down = i;
        end
        if image(j,i) ~= 0
            if left > i
                left = i;
            end
            right = i;
        end
    end
end

for i = 1 : sizee
    for j = 1 : sizee
        if image(i,j) == 1
            image(i,j) = 0;
        else
            image(i,j) = 1;
        end
    end
end

% ÃÜ¶È
imag = image(top:down,left:right);
% x = V(154:163);
% y = V(164:173);
% hist(y);


% fft2
imagfft = fft2(imag);
imagfft(1,1) = 0;
fftz = zeros(size(imag,1),size(imag,2));
fftz(1,3) = imagfft(1,3);
fftz(1,2) = imagfft(1,2);
fftz(2,1) = imagfft(2,1);
fftz(2,2) = imagfft(2,2);

fftz(size(imag,1)-1 ,1) = imagfft(size(imag,1)-1,1);
fftz(size(imag,1)-1 ,2) = imagfft(size(imag,1)-1,2);
fftz(size(imag,1) ,1) = imagfft(size(imag,1),1);
fftz(size(imag,1) ,2) = imagfft(size(imag,1),2);

fftz(size(imag,1)-1 ,size(imag,2) -1 ) = imagfft(size(imag,1)-1,size(imag,2) -1);
fftz(size(imag,1)-1 ,size(imag,2)  ) = imagfft(size(imag,1)-1,size(imag,2) );
fftz(size(imag,1) ,size(imag,2) -1 ) = imagfft(size(imag,1),size(imag,2) -1);
fftz(size(imag,1),size(imag,2)  ) = imagfft(size(imag,1),size(imag,2) );

fftz(1 ,size(imag,2) -1 ) = imagfft(1,size(imag,2) -1);
fftz(1 ,size(imag,2)  ) = imagfft(1,size(imag,2) );
fftz(2 ,size(imag,2) -1 ) = imagfft(2,size(imag,2) -1);
fftz(2 ,size(imag,2)  ) = imagfft(2,size(imag,2) );


imifft = ifft2(fftz);
subplot(1,2,1);
imshow(imifft);

fftx = zeros(size(imag,1),size(imag,2));
x = round(size(imag,1)/2)-2;
y = round(size(imag,2)/2)-2;
for i = 1 : 4
    for j = 1: 4
        fftx(x + i,y +j) = imagfft(x+i,y+j);
    end
end
% 
% imifft = ifft2(fftx);
% subplot(1,2,2);
% imshow(imifft);




% ÖØÐÄ
% x = V(140)*(down - top + 1);
% y = V(141)*( right - left + 1);
% plot(y,x,'r.');
% plot(y,x,'ro');
% x = V(151);
% y = V(152);
% plot(y,x,'c*');
% x = V(142);
% y = V(143);
% plot(y,x,'c*');
% x = V(145);
% y = V(146);
% plot(y,x,'c*');
% x = V(148);
% y = V(149);
% plot(y,x,'c*');
% x = size(imag,1);
% y = size(imag,2);
% plot([1,y],[x/2,x/2],'y-');
% plot([y/2,y/2],[1,x],'y-');