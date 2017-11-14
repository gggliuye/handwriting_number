function [ R  ] = facture( image , size)
% get the facture of the image

% cut the image
for i = 1 : size
    for j = 1 : size
        if image(i,j) == 0
            image(i,j) = 1;
        else
            image(i,j) = 0;
        end
    end
end


top = size;
left = size;
down = size;
right = size;
for i = 1 : size
    for j = 1 : size
        if image(i, j) ~= 0
            if top > i 
                top = i;
            end
            down = i;
        end
        if image(j,i) ~= 0
            if left > i
                left = i;
            end
            right = i;
        end
    end
end

% % 1 facture - strat from left
% 
% cut = 20;
% d = (down - top)/(cut - 1);
% f1 = ones (cut,1);
% length = right - left;
% for i = 1 : cut
%     line = round(top + (i-1) * d);
%     for j = 0 : length
%         if image( line , j + left ) ~= 0 
%             f1(i) = j/length;
%             break;
%         end
%     end
% end
% 
% % 2 fecture - start from top 
% 
% d = (right - left)/(cut - 1);
% f2 = ones (cut ,1);
% length = down - top;
% for i = 1 : cut
%     list = round(left + (i-1) * d);
%     for j = 0 : length
%         if image( j + top , list ) ~= 0 
%             f2(i) = j/length;
%             break;
%         end
%     end
% end
% 
% % 3 fecture - start from right 
% 
% d = (down - top)/(cut - 1);
% f3 = ones (cut,1);
% length = right - left;
% for i = 1 : cut
%     line = round(top + (i-1) * d);
%     for j = 0 : length
%         if image( line , right - j ) ~= 0 
%             f3(i) = j/length;
%             break;
%         end
%     end
% end
% 
% % 4 - start from down
% 
% d = (right - left)/(cut - 1);
% f4 = ones (cut ,1);
% length = down - top;
% for i = 1 : cut
%     list = round(left + (i-1) * d);
%     for j = 0 : length
%         if image( down - j , list ) ~= 0 
%             f4(i) = j/length;
%             break;
%         end
%     end
% end
% 
% % 5 - how much point black - start from left
% cut = 10;
% d = (down - top)/(cut - 1);
% f5 = zeros (cut,1);
% length = right - left;
% for i = 1 : cut
%     line = round(top + (i-1) * d);
%     for j = 0 : length-1
%         if image( line , j + left ) == 0 && image( line, j +left +1) == 1
%             f5(i) = f5(i) + 1;
%         end
%     end
% end
% 
% 
% % 6 - how much point black - start from top
% 
% d = (right - left)/(cut - 1);
% f6 = zeros (cut ,1);
% length = down - top;
% for i = 1 : cut
%     list = round(left + (i-1) * d);
%     for j = 0 : length-1
%         if image( j + top , list ) == 0 && image ( j + top + 1, list) == 1
%             f6(i) = f6(i) + 1;
%         end
%     end
% end


% komori

komori = zeros(size,size,8);
for i = top : down
    for j = left :right
        if image(i,j) == 0
            % 1 direction north
             for dir = top : i
                 if image(dir , j ) ~= 0
                     komori(i,j,1) = 1;
                 end
             end
            % 2 direction north-east
             x = i ; 
             y = j;
             while(x >= top && y <= right)
                 if image(x,y) ~= 0
                     komori(i,j,2) = 1;
                 end
                 x = x - 1;
                 y = y + 1;
             end
            % 3 direction east
             for dir = j : right
                 if image(i , dir ) ~= 0
                     komori(i,j,3) = 1;
                 end
             end
            % 4 direction south-east
             x = i ; 
             y = j;
             while(x <= down && y <= right)
                 if image(x,y) ~= 0
                     komori(i,j,4) = 1;
                 end
                 x = x + 1;
                 y = y + 1;
             end
            % 5 direction south
             for dir = i : down
                 if image(dir , j ) ~= 0
                     komori(i,j,5) = 1;
                 end
             end
             % 6 direction south-west
             x = i ; 
             y = j;
             while(x <= down && y >= left)
                 if image(x,y) ~= 0
                     komori(i,j,6) = 1;
                 end
                 x = x + 1;
                 y = y - 1;
             end
             % 7 direction west
             for dir = left : i
                 if image(i , dir) ~= 0
                     komori(i,j,7) = 1;
                 end
             end
            % 8 direction north-west
             x = i ; 
             y = j;
             while(x >= top && y >= left)
                 if image(x,y) ~= 0
                     komori(i,j,8) = 1;
                 end
                 x = x - 1;
                 y = y - 1;
             end
        end
    end
end

fkomori = zeros ( 41*3 ,1);
fkomori1 = zeros ( 41 ,1);
dis = (down - top)/3;
for zone = 1 :3
    topx = floor(top + (zone - 1)*dis);
    downx = floor(top + zone * dis);
    for i = topx : downx
        for j = left : right
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(41) = fkomori1(41) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 0 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(1) = fkomori1(1) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 0 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(2) = fkomori1(2) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(3) = fkomori1(3) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 0)
                fkomori1(4) = fkomori1(4) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 0 && komori(i,j,8) == 1)
                fkomori1(5) = fkomori1(5) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 0 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(6) = fkomori1(6) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 0 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(7) = fkomori1(7) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 0 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(8) = fkomori1(8) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(9) = fkomori1(9) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(10) = fkomori1(10) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 0)
                fkomori1(11) = fkomori1(11) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(12) = fkomori1(12) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 1)
                fkomori1(13) = fkomori1(13) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(14) = fkomori1(14) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(15) = fkomori1(15) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(16) = fkomori1(16) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(17) = fkomori1(17) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(18) = fkomori1(18) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 0)
                fkomori1(19) = fkomori1(19) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(20) = fkomori1(20) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(21) = fkomori1(21) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 1)
                fkomori1(22) = fkomori1(22) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(23) = fkomori1(23) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(24) = fkomori1(24) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(25) = fkomori1(25) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 0)
                fkomori1(26) = fkomori1(26) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(27) = fkomori1(27) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(28) = fkomori1(28) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(29) = fkomori1(29) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 1)
                fkomori1(30) = fkomori1(30) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(31) = fkomori1(31) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(32) = fkomori1(32) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(33) = fkomori1(33) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 1 && komori(i,j,8) == 0)
                fkomori1(34) = fkomori1(34) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 1 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(35) = fkomori1(35) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 0 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 1 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(36) = fkomori1(36) + 1;
            end
            if ( komori(i,j,1) == 0 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 1 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(37) = fkomori1(37) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 1 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 0)
                fkomori1(38) = fkomori1(38) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 1 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 0 && komori(i,j,8) == 1)
                fkomori1(39) = fkomori1(39) + 1;
            end
            if ( komori(i,j,1) == 1 && komori(i,j,2) == 0 && komori(i,j,3) == 0 && komori(i,j,4) == 0 && komori(i,j,5) == 0 && komori(i,j,6) == 0 && komori(i,j,7) == 1 && komori(i,j,8) == 1)
                fkomori1(40) = fkomori1(40) + 1;
            end
        end
    end
    n = max(fkomori1);
    for i = 1 : 41
        fkomori1(i) = fkomori1(i) / n;
    end
    fkomori(41*(zone-1)+1:41*zone) = fkomori1;
end



% fourier transform

% fftimage = fft2(image(top:down,left:right));
% facturefft = zeros (40,1);
% line = down - top + 1;
% list = right - left + 1;
% for i = 1 : 20
%     x = round(((line-1)/19)*(i-1) + 1);
%     y = round(((list-1)/19)*(i-1) + 1);
%     facturefft(i) = fftimage(x,y);
% end
% for i = 1 : 20
%     x = round(((line-1)/19)*((20-i)) + 1);
%     y = round(((list-1)/19)*(i-1) + 1);
%     facturefft(20+i) = fftimage(x,y);
% end
% m = max(abs(facturefft));
% 
% for i = 1:40
%     facturefft(i) =abs( facturefft(i))/m;
% end

%fft取四个角的值

fftimage = fft2(image(top:down,left:right));
index = 1;
n = 2;
te = n*n*4;
facturefft = zeros (te,1);
dx = max(floor((down - top)/10),1);
dy = max(floor((right - left)/10),1);
q = down - top + 1-(n-1)*dx;
p = right - left +1-(n-1)*dy;
kx = [ 1, 1,q, q];
ky = [ 1, p, 1,p];
% kx = [ 2, 2,q-1, q-1];
% ky = [ 2, p-1, 2,p-1];
for t = 1 : 4
    for i = kx(t) : dx: kx(t) +( n -1)*dx
        for j = ky(t) :dy : ky(t) + (n -1)*dy
            facturefft(index) = abs(fftimage(i,j));
            index = index + 1;
        end
    end
end
facturefft(1) = abs(fftimage(n,n+1));
        
% 重心 
zhongxin = zeros(2,1);
number = 0;
for i = top : down
    for j = left : right
        if image(i,j) == 1
            zhongxin(1) = zhongxin(1) + i;
            zhongxin(2) = zhongxin(2) + j;
            number = number + 1;
        end
    end
end
zhongxin(1) = ((zhongxin(1)/number) - top + 1)/(down - top + 1);
zhongxin(2) = ((zhongxin(2)/number) - left + 1)/(right - left + 1);


%四个象限的重心以及重心距
mid1 = floor((down + top)/2);
mid2 = floor((left + right)/2);
topx = [ top, top, (mid1+1), (mid1+1)];
downx = [ mid1, mid1, down , down];
leftx = [left, (mid2+1), left, (mid2 +1)];
rightx = [mid2 ,right, mid2, right];
zhongxin1 = zeros(12,1);

for n = 1 : 4
    index = 0;
    number = 0;
    for i = topx(n) : downx(n)
       for j = leftx(n) : rightx(n)
           if image(i,j) == 1
               zhongxin1(3*n -2) = zhongxin1(3*n-2) + i ;
               zhongxin1(3*n -1) = zhongxin1(3*n-1) + j ;
               number = number + 1;
               index = index + 1;
           end
       end
    end


   for i = topx(n) : downx(n)
       for j = leftx(n) : rightx(n)
           if image(i,j) == 1
               zhongxin1(3*n) = zhongxin1(3*n) + sqrt((zhongxin1(3*n -2)/number - i)^2 + (zhongxin1(3*n -1)/number - j )^2);
           end
       end
   end
   
   zhongxin1(3*n - 2) = (zhongxin1(3*n - 2)/number) - top + 1;
   zhongxin1(3*n - 1) = (zhongxin1(3*n - 1)/number) - left + 1;
   zhongxin1(3*n) = zhongxin1(3*n)/number;
   
   if index == 0
       zhongxin1(3*n - 2) = 0;
       zhongxin1(3*n - 1) = 0;
       zhongxin1(3*n) = 0;
   end
   
end

% 各个方向的密度分布

n = 10;
fa = zeros(2*n ,1);
index = 1;
%shu
for i = 1 :n
    temp = 0;
    x = top + round((down - top)*(i-1)/(n-1));
    for j = left : right
        if image(x, j) == 1
            temp = temp + 1;
        end
    end
    fa(index) = temp/(right - left + 1);
    index = index + 1;
end

%heng
for i = 1 : n 
    temp = 0;
    y = left + round((right - left)*(i-1)/(n-1));
    for j = top : down
        if image(j, y) == 1
            temp = temp + 1;
        end
    end
    fa(index) = temp/(down - top + 1);
    index = index + 1;
end




% get the vextors together
% 123 + 16 + 2 + 12 + 20 = 173
R = [ fkomori ; facturefft; zhongxin; zhongxin1;fa];

end
