circle = csvread('hw5_circle.csv');
blob = csvread('hw5_blob.csv');
marker=['x', 'o', '+', '*', 's'];
% blob_data = load('hw5_blob.mat');
% blob = blob_data.points;
k_name = cellstr(char('K-means k = 2', 'K-means k = 3', 'K-means k = 5'));

no_of_clusters = [2, 3, 5];


% clusters_old = repmat(3,rows,1);
% clusters_new = repmat(5,rows,1);
% f =  figure('Name', 'Blob Data Set');
for i = 1 : length(no_of_clusters)
    % disp( k(i) );
    k = no_of_clusters(i);
%     rows = length(blob);
%     rand_idx = randi(rows, 1, k)
%     mu = blob(rand_idx,:)

%     fprintf('K-means k = %d', k);
%     str = 'K-means k = ' + num2str(k); 
    cluster = kmeans(blob, k);
    grp1 = blob(cluster==1,:);
    grp2 = blob(cluster==2,:);
    grp3 = blob(cluster==3,:);
    grp4 = blob(cluster==4,:);
    grp5 = blob(cluster==5,:);
    f =  figure('Name', k_name{i});
    hold on;
%     subplot(1,3,i)
%     scatter(circle(:,1), circle(:,2), [], cluster, 'filled');
    scatter(grp1(:,1), grp1(:,2), marker(1))
    scatter(grp2(:,1), grp2(:,2), marker(2))
    scatter(grp3(:,1), grp3(:,2), marker(3))
    scatter(grp4(:,1), grp4(:,2), marker(4))
    scatter(grp5(:,1), grp5(:,2), marker(5))
%     subplot(1,3,i)
%     scatter(blob(:,1), blob(:,2), [], cluster, 'filled');
    title(sprintf('k-means | Blob dataset | K=%d', k));
    xlabel('x1');
    ylabel('x2');
    s = sprintf('blob-%d.jpg',k);
%     saveas(f,s);
   
end

% f =  figure('Name', 'Circle Data Set');
for i = 1 : length(no_of_clusters)
    % disp( k(i) );
    k = no_of_clusters(i);
%     rows = length(blob);
%     rand_idx = randi(rows, 1, k)
%     mu = blob(rand_idx,:)
%     fprintf('K-means k = %d', k);
%     str = 'K-means k = ' + num2str(k); 
    cluster = kmeans(circle, k);
    grp1 = circle(cluster==1,:);
    grp2 = circle(cluster==2,:);
    grp3 = circle(cluster==3,:);
    grp4 = circle(cluster==4,:);
    grp5 = circle(cluster==5,:);
    f =  figure('Name', k_name{i});
    hold on;
%     subplot(1,3,i)
%     scatter(circle(:,1), circle(:,2), [], cluster, 'filled');
    scatter(grp1(:,1), grp1(:,2), marker(1))
    scatter(grp2(:,1), grp2(:,2), marker(2))
    scatter(grp3(:,1), grp3(:,2), marker(3))
    scatter(grp4(:,1), grp4(:,2), marker(4))
    scatter(grp5(:,1), grp5(:,2), marker(5))
    title(sprintf('k-means | Circle dataset | K=%d', k));
    xlabel('x1');
    ylabel('x2');
    s = sprintf('circle-%d.jpg',k);
%     saveas(f,s);
end



