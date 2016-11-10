function [ clusters, mu ] = kkmeans( data_set, k)
%Random initilisation of clusters
k=2;
rows = length(data_set);
clusters = zeros(rows);
rand_idx = randi(rows, 1, k);

norm_data = sum(data_set.^2,2);
min_pos = find(norm_data == min(norm_data));
clusters(min_pos,:) = 2;
mu2 = sum(data_set,1)-data_set(min_pos,:);
mu = [data_set(min_pos,:);mu2/(rows-1)];
end_flag = false;
x = 0;
while (~end_flag)
    % compute l2_dist
    l2_dist = pdist2(data_set, mu);
    %           l2_dist = norm(data_set - mu);
    %     l2_dist_1 = pdist2(mu, data_set);
    % find which centroid is closer to each point
    [M, I] = min(l2_dist, [], 2);
    %     [M_1, I_1] = min(l2_dist_1, [], 2);
    clusters = I;
    
    for i = 1:k
        % find the indices pf the point which belong to cluter i
        c_idx = find(clusters==i);
        % recompute mu
        mu_new = mu;
        mu_new(i,:) = sum( data_set(c_idx,:) , 1) / length(c_idx);
    end
    x = x + 1;
    diff = abs(sum(mu - mu_new));
    if (diff < 0.000000001)
        end_flag = true;
    else
        mu = mu_new;
        
    end
    x;
end

