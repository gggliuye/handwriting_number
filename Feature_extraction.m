function [ S_w ] = Feature_extraction( V , d)
%FEATURE_EXTRACTION extract features due to the original feature
%   use euclid distance
global num_learn;
ex_num_learn = [0,num_learn];
num = sum(num_learn);
%Calculate the average position
u = ones(1,223);
u_each = ones(1,223,10);
u(:,:) = sum(V,1)/num;
for i = 1:10
    u_each(:,:,i) = sum(V(ex_num_learn(i)+1 : ex_num_learn(i+1),:) , 1)/num_learn(i); 
end
%Calculate the matrix S_b and S_w
S_b = zeros(223,223);
S_w = zeros(223,223);
for i = 1:10
   S_b = S_b + num_learn(i)/num*(u_each(:,:,i) - u)'*(u_each(:,:,i) - u);
end
for i = 1:10
   for j = ex_num_learn(i)+1 : ex_num_learn(i+1)
      S_w = S_w + ((V(j,:) - u_each(:,:,i))'*(V(j,:) - u_each(:,:,i)))/num;
   end
end
%calculate the transitional matrix
%S = S_w\S_b;
%sort
%[f_vec, f_num] = eig(S);
%F_num = eig(S);
%[~, F_num_index] = sort(F_num , 'descend');
%F_vec_sort = f_vec(:,F_num_index);
%create the new feature vector
%W = F_vec_sort(:,1:d);
%X = W'*V';
end

