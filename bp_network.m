clear all
close all
clc

%V
load('Vappr.mat');
%V1
load('Vtest.mat');

%Index
load('matlab.mat');

% Index(100:120) = [];
% siz = size(V,2);
% Index = [1 : siz];

Va = zeros(4456,size(Index,2));
Vt = zeros(4545,size(Index,2));
for i = 1 : size(Index,2)
    Va(:,i) = V(:,Index(i));
    Vt(:,i) = V1(:,Index(i));
end



% set up the network
% net = newff(minmax(V'), [10,10], {'logsig','purelin'},'traingdx');
% 
% % set param
% % net.trainparam.show = 50;
% net.trainparam.epochs = 500;
% net.trainparam.goal = 0.01;
% % net.trainParam.lr = 0.01;


net = feedforwardnet(10);
% net.trainParam.epochs = 100000000;
% net.trainParam.goal = 0.0001;
% net.layers{1}.transferFcn = 


% set output
num = [489 452 452 453 431 409 452 449 447 422];
output = zeros(4456,10);
ind = 1;
for n = 1 : 10
    for i = ind : ind + num(n) -1
        output(i,n) = 1;
    end  
    ind = ind + num(n);
end

% train
% net.trainFcn = 'trainbr';
% % net.trainParam.max_fail = 20;

tic;
y = train(net , Va', output');
tim = toc;

tim
% sim

Y = sim(y, Vt');

decide = zeros(4545,1);
for i = 1: 4545
    [m,decide(i)] = max(Y(:,i));
end

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