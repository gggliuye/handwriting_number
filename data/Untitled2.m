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
i = 10;
k = 55;


    name = file_name(i,:);
    data(:,:,:,i) = Read_in_data(name);

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

imag = image(top:down,left:right);

n1 = size(imag,1);
n2 = size(imag,2);
fa = zeros((n1+n2),1);
index = 1;
%shu
for i = 1 :n1
    temp = 0;
    x = top + round((down - top)*(i-1)/(n1-1));
    for j = left : right
        if image(x, j) == 0
            temp = temp + 1;
        end
    end
    fa(index) = temp;
    index = index + 1;
end

%heng
for i = 1 : n2 
    temp = 0;
    y = left + round((right - left)*(i-1)/(n2-1));
    for j = top : down
        if image(j, y) == 0
            temp = temp + 1;
        end
    end
    fa(index) = temp;
    index = index + 1;
end

x = fa(1:n1);
y = fa(1+n1:n1+n2);