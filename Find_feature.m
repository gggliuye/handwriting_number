function [ Index ] = Find_feature(V, index)
%FIND_FEATURE Summary of this function goes here
%   Detailed explanation goes here
index_0 = find(index == 0);
k = 0;
a = [0 0];
for i = 1 : length(index_0) - 1
   index(index_0(i)) = 1;
   for j = i+1 : length(index_0)
      index(index_0(j)) = 1;
      J_temp = Calculate_feature_new(V,index);
      if J_temp>=k
         k = J_temp; 
         a = [i j];
      end
      index(index_0(j)) = 0;
   end
   index(index_0(i)) = 0;
end
index(index_0(a(1))) = 1;
index(index_0(a(2))) = 1;
Index = index;
end

