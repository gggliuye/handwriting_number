function [ Total_image ] = Read_in_data(name_of_file)
%Read in the data of the image
%   make some primary treatment
Total_image = ones(64,64,640);
t = imread(name_of_file);
k = 1;
for i = 1:32
    for j = 1:20
        Total_image(:,:,k) = t(((i-1)*64+1):(i*64),((j-1)*64+1):(j*64));
        k = k+1;
    end   
end
end

