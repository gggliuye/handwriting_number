function [ d ] = dist( x,y ,s)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
d = 0;
for i = 1 :s
    d = d + (x(i)-y(i))^2;
end
d = sqrt(d);

end

