clear all
close all
clc

%V
load('Vappr.mat');


det = zeros(300,1);
index = 1;
temp = 0;
for i = 1 : size(V,2)
    for j = 1 : size(V,1)
        if V(j,i) > 0.05
            temp = temp + 1;
        end
    end
    ma = max(V(:,i));
    mi = min(V(:,i));
    if ~(temp >= 400 && (ma - mi) >= 0.2)
        det(index) = i;
        index = index + 1;
    end
end


% ind = index - 1;
% while (ind ~= 0)
%     V(:,det(ind)) = [];
%     ind = ind -1;
% end