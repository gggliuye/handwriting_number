function [ J ] = Calculate_feature_new( V , index )
%CALCULATE_FEATURE_NEW Summary of this function goes here
%   Detailed explanation goes here
global num_learn;
ex_num_learn = [0,num_learn];
num = sum(num_learn);
a = find(index ~= 0);
n = length(a);
V_new = V(:,a);
u = ones(1,n);
u_each = ones(1,n,10);
u(:,:) = sum(V_new,1)/num;
for i = 1:10
    u_each(:,:,i) = sum(V_new(ex_num_learn(i)+1 : ex_num_learn(i+1),:) , 1)/num_learn(i); 
end
k = 0;
j1 = 0;
for i = 1:10
    j1 = j1 + (u_each(:,:,i) - u)*(u_each(:,:,i) - u)';
   for j = ex_num_learn(i) +1 : ex_num_learn(i+1)
       k = k + (V_new(j , :) - u_each(:,:,i))*(V_new(j , :) - u_each(:,:,i))';
   end
end
J = j1*num_learn(i)/num + k/num;
end

