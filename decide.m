clear all
close all
clc

load('decide.mat');


wrong = zeros (10,1);
num = [465 465 462 464 429 431 463 464 456 446];
ind = 1;
for n = 1 : 10
    for i = ind : ind + num(n) -1
        if decide(i) ~= n
            wrong(n) = wrong(n) + 1;
        end
    end
    wrong(n) = wrong(n)/num(n);
    ind = ind + num(n);
end

mean(wrong)
std(wrong)
wrong=wrong';