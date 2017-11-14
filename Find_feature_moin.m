function [ Index ] = Find_feature_moin( V, index )
%FIND_FEATURE_MOIN Summary of this function goes here
%   Detailed explanation goes here
index_0 = find(index ~= 0);
j = 0;
a = 0;
for i = 1 : length(index_0)
    index(index_0(i)) = 0;
    J_temp = Calculate_feature_new(V,index);
    if J_temp>=j
         j = J_temp; 
         a = i;
    end
    index(index_0(i)) = 1;
end
index(index_0(a)) = 0;
Index = index;
end

