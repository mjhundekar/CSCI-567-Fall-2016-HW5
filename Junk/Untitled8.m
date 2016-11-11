K=2;
% points = load('hw5_circle.mat');
points = csvread('hw5_circle.csv');
assgnOld = ones(size(points, 1), 1);
s = sum(points.^2, 2);
pos = find(s==min(s));
assgnOld(pos, :) = 2;
assgnNew = randi(2, size(points, 1), 1);
kDist = zeros(size(points,1), 2);
G = (points*points').^2;


while (1)
    for i=1:size(points, 1)
        for k=1:K
            
            term1 = 0;
            count = 0;
            for j = 1:size(points, 1)
                if assgnOld(j,1)==k
                    term1 = term1 + G(i,j);
                    count = count + 1;
                end
            end
            term1 = term1/count;
            
            term2 = 0;
            for j = 1:size(points, 1)
                if assgnOld(j,1)==k
                    for l = 1:size(points, 1)
                        if assgnOld(l,1)==k
                            term2 = term2 + G(j,l);
                        end
                    end
                end
            end
            term2 = term2/(count^2);
            
            kDist(i,k) = G(i,i) - 2*term1 + term2;
        end
        if kDist(i,1)<kDist(i,2)
            assgnNew(i,1)=1;
        else
            assgnNew(i,1)=2;
        end
    end
    
    if sum(abs(assgnOld-assgnNew))==0
        break;
    else
        assgnOld=assgnNew;
    end
end
mat1 = points(find(assgnNew==1), :);
mat2 = points(find(assgnNew==2), :);
figure;
hold on;
plot(mat1(:,1), mat1(:,2), 'r.')
plot(mat2(:,1), mat2(:,2), 'gx')
title(['Kernel K-Means with Clusters: ',num2str(K)]);

