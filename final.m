clear all
close all
clc

load('decide.mat');

file_name = ['F:\france\ES203\ES 203\rec_0.bmp';'F:\france\ES203\ES 203\rec_1.bmp';'F:\france\ES203\ES 203\rec_2.bmp';'F:\france\ES203\ES 203\rec_3.bmp';'F:\france\ES203\ES 203\rec_4.bmp';'F:\france\ES203\ES 203\rec_5.bmp';'F:\france\ES203\ES 203\rec_6.bmp';'F:\france\ES203\ES 203\rec_7.bmp';'F:\france\ES203\ES 203\rec_8.bmp';'F:\france\ES203\ES 203\rec_9.bmp'];
num = [465 465 462 464 429 431 463 464 456 446];

%read in files
data = ones(64,64,640,10);
for i = 1 :10
    name = file_name(i,:);
    data(:,:,:,i) = Read_in_data(name);
end

decide1 = zeros(500,10);
index = 1;
for n = 1 : 10
    decide1(1:num(n),n) = decide(index :index + num(n) -1);
    index = index + num(n);
end



for n = 1 : 10
    temp = ones(32*64,20*64);
    x = 1;
    y = 1;
    for k = 1 : 10
        for i = 1 : num(k)
            if decide1(i,k) == n
                temp(((x-1)*64+1):x*64,((y-1)*64+1):y*64) = data(:,:,i,k);
                y = y + 1;
                if y == 21
                    y = 1;
                    x = x + 1;
                end
            end
        end
    end
    file = ['F:\france\ES203\result\',num2str(n),'haha.jpg'];
    imwrite(temp,file);
end
            
            
            
            