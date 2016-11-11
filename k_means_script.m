circle = csvread('hw5_circle.csv');
blob = csvread('hw5_blob.csv');

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
    f =  figure('Name', k_name{i});
%     subplot(1,3,i)
    scatter(blob(:,1), blob(:,2), [], cluster, 'filled');
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
    f =  figure('Name', k_name{i});
%     subplot(1,3,i)
    scatter(circle(:,1), circle(:,2), [], cluster, 'filled');
    title(sprintf('k-means | Circle dataset | K=%d', k));
    xlabel('x1');
    ylabel('x2');
    s = sprintf('circle-%d.jpg',k);
%     saveas(f,s);
end



