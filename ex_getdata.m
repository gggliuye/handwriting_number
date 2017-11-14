
clear all 
close all
clc

nx = 173;

maxin = zeros(nx, 1);
num_learn = [489 452 452 453 431 409 452 449 447 422];
file_name = ['F:\france\ES203\ES 203\appr_0.bmp';'F:\france\ES203\ES 203\appr_1.bmp';'F:\france\ES203\ES 203\appr_2.bmp';'F:\france\ES203\ES 203\appr_3.bmp';'F:\france\ES203\ES 203\appr_4.bmp';'F:\france\ES203\ES 203\appr_5.bmp';'F:\france\ES203\ES 203\appr_6.bmp';'F:\france\ES203\ES 203\appr_7.bmp';'F:\france\ES203\ES 203\appr_8.bmp';'F:\france\ES203\ES 203\appr_9.bmp'];
[V, maxafter] = Create_vector(nx,num_learn,file_name,maxin);

det = zeros(300,1);
index = 1;

for i = 1 : size(V,2)
    temp = 0;
    for j = 1 : size(V,1)
        if V(j,i) > 0.05
            temp = temp + 1;
        end
    end
    ma = max(V(:,i));
    mi = min(V(:,i));
    if temp <= 80 || (ma-mi) <= 0.08
        det(index) = i;
        index = index + 1;
    end
end
ind = index - 1;
while (ind ~= 0)
    V(:,det(ind)) = [];
    ind = ind -1;
end

num_learn = [465 465 462 464 429 431 463 464 456 446];
file_name = ['F:\france\ES203\ES 203\rec_0.bmp';'F:\france\ES203\ES 203\rec_1.bmp';'F:\france\ES203\ES 203\rec_2.bmp';'F:\france\ES203\ES 203\rec_3.bmp';'F:\france\ES203\ES 203\rec_4.bmp';'F:\france\ES203\ES 203\rec_5.bmp';'F:\france\ES203\ES 203\rec_6.bmp';'F:\france\ES203\ES 203\rec_7.bmp';'F:\france\ES203\ES 203\rec_8.bmp';'F:\france\ES203\ES 203\rec_9.bmp'];
[V1, maxafter1] = Create_vector(nx,num_learn,file_name, maxafter);

ind = index - 1;
while (ind ~= 0)
    V1(:,det(ind)) = [];
    ind = ind -1;
end

%learn
save('F:/france/ES203/dong/Vappr.mat','V');
%test
save('F:/france/ES203/dong/Vtest.mat','V1');

%nb = [1 2 12 13 14 15 16 17 20 21 22 39 40 47 48 49 60 61 79 80 81 82 83 85 88 93 94 95 96 98];
% nb = [1 2 13 14 15 16 20 21 22 40 48 60 61 79 80 91 92 93 94 95 96 97 98 99 100 136 141 182 222 223];
% M = [];
% 
% for i = 1: size(nb,2)
%     M = [M, V1(:,nb(i))];
% end


