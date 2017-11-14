function [ decide ] = bay( x , y )
decide = 1;
max = 0;

num = [489 452 452 453 431 409 452 449 447 422];
fac = 17;
n2 = size(x,2);
sum = 0;
ind = 1;
d = zeros ( 10,1);
for n = 1 : 10
    for i = ind : ind + num(n) -1
        for j = 1 : n2
            sum = sum + (y(j) - x(i,j))*(y(j) - x(i,j));
        end
%         if sum < 5
%             d(n) = d(n) + 1;
%         end
%         
        
        d(n) = d(n) + (1000/num(n)) * exp( - fac*sum);
         sum = 0;
    end
    ind = ind + num(n);
end

for i = 1 : 10
    if max <= d(i)
        decide = i;
        max = d(i);
    end
end
decide = decide -1;

end

