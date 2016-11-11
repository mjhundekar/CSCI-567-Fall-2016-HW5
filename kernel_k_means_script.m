%Kernel K means
circle = csvread('hw5_circle.csv');
marker=['x', 'o', '+', '*', 's'];
k = 2;

% rbf_K = rbf_kernel(0.5, circle);
% gaus_k = gaussian_kernel(circle, 0, 0.5);

G = (circle * circle').^2;

length(circle(1,:));
% size(circle,1)
cluster = k_kmeans(G,2);
grp1 = circle(cluster==1,:);
grp2 = circle(cluster==2,:);

% cluster, mu = kmeans(G, 2);
f =  figure('Name', 'Kernel K means');
hold on;
%     subplot(1,3,i)
%     scatter(circle(:,1), circle(:,2), [], cluster, 'filled');
    scatter(grp1(:,1), grp1(:,2), marker(1))
    scatter(grp2(:,1), grp2(:,2), marker(2))
    
% scatter(circle(:,1), circle(:,2), [], cluster, 'filled');
title(sprintf('kernel k-means | Circle dataset | K=%d', k));
xlabel('x1');
ylabel('x2');
s = sprintf('kernel_circle-%d.jpg',k);
% saveas(f,s);
