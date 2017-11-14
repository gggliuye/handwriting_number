clear all
close all
clc


nn = 141;
%V
load('Vappr.mat');
%V1
load('Vtest.mat');
%learn
numa = [489 452 452 453 431 409 452 449 447 422];
vx = zeros(500,nn,10);
index = 1;
for i = 1 : 10
    vx(1:numa(i),:,i) = V(index:index+numa(i)-1,:);
    index = index + numa(i);
end
%test
numt = [465 465 462 464 429 431 463 464 456 446];
vy = zeros(500,nn,10);
index = 1;
for i = 1 : 10
    vy(1:numt(i),:,i) = V1(index:index+numt(i)-1,:);
    index = index + numt(i);
end



for nx = 1 : 10
    for ix = 1 : numa(nx)
        dmax1 = inf;
        dmax2 = inf;
        nmax1 = 0;
        nmax2 = 0;
        for ny = 1 : 10
            for iy = 1 : numa(ny)
               if sum(vx(ix,:,nx))~= 0 && sum(vx(iy,:,ny)) ~= 0
                    d = dist(vx(iy,:,ny),vx(ix,:,nx),nn) ;
                    if d < dmax1
                       dmax2 = dmax1;
                       dmax1 = d;
                       nmax2 = nmax1;
                       nmax1 = ny;
                    end
               end
            end
        end
        if nx ~= nmax1 && nx ~= nmax2
            vx(ix,:,nx) = 0;
        end
    end
end



decide = zeros(500,10);

for n = 1 : 10
    for i = 1 : numt(n)
        dmin = inf;
        nmin = 0;
        for k = 1 : 10
            for j = 1 : numa(k)
                if sum(vx(j,:,k))~= 0 && sum(vy(i,:,n)) ~= 0
                    d = dist(vx(j,:,k),vy(i,:,n),nn) ;
                    if d < dmin
                        dmin = d;
                        nmin = k;
                    end
                end
            end
        end
        decide(i,n) = nmin;
    end
end


wrong = zeros(10,1);
for n = 1 : 10
    temp = 0;
    for i = 1 : numt(n)
        if decide(i,n) ~= n
            temp = temp + 1;
        end
    end
    wrong(n) = temp / numt(n)
end
            

save('F:/france/ES203/dong/wrongppv.mat','wrong');
  