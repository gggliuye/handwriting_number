function [ d ] = dist( x,y ,s)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
d = 0;
for i = 1 :s
    d = d + (x(i)-y(i))^2;
end
d = sqrt(d);

end

