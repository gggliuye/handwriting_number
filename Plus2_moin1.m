function [ X ] = Plus2_moin1(V, d )
%PLUS2_MOIN1 plus 2 moin 1 to get the best feature
%   from bottom to d
index = zeros(1,223);
for i = 1 : d
   index = Find_feature(V,index)
   index = Find_feature_moin(V,index);
end
Index = find(index ~= 0);
X = V(:,Index);
end

