function [ V , maxafter] = Create_vector( nx,num_learn,file_name , maxin)
%CREATE_VECTOR create the feature vector
%   still need improvement
num = sum(num_learn);
V = ones(num,nx);
%read in files
data = ones(64,64,640,10);
for i = 1:10
    name = file_name(i,:);
    data(:,:,:,i) = Read_in_data(name);
end
%create vector
temp = 1;
for i = 1:10
    for k = 1:num_learn(i)
         V(temp,:) = facture(data(:,:,k,i) , 64); 
         temp = temp + 1;
    end
end

for i = 1:nx
    if size(V,1) == 4456
        maxin(i) = max(V(:,i))- min(V(:,i)) ;
    end
    V(:,i) = (V(:,i)- min(V(:,i)) )/maxin(i);
    if maxin(i) == 0
        V(:,i) = 0;
    end
end

maxafter = maxin;

end

