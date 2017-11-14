clear all
close all
clc

%V
load('Vappr.mat');
%V1
load('Vtest.mat');
%Index
% load('index.mat');

% Index(100:120) = [];
siz = size(V,2);
Index = [1 : siz];

Va = zeros(4456,size(Index,2));
Vt = zeros(4545,size(Index,2));
for i = 1 : size(Index,2)
    Va(:,i) = V(:,Index(i));
    Vt(:,i) = V1(:,Index(i));
end

decide = zeros(4545,1);
for i = 1: 4545
    decide(i) = bay(Va,Vt(i,:));
end

wrong = zeros (10,1);

num = [465 465 462 464 429 431 463 464 456 446];
ind = 1;
for n = 1 : 10
    for i = ind : ind + num(n) -1
        if decide(i) ~= (n-1)
            wrong(n) = wrong(n) + 1;
        end
    end
    wrong(n) = wrong(n)/num(n);
    ind = ind + num(n);
end

save('F:/france/ES203/dong/wrong.mat','wrong');
mean(wrong)
std(wrong)
wrong = wrong';

