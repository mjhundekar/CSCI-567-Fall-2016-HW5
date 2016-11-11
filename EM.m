blob = csvread('hw5_blob.csv');
k = 3;
N = length(blob(:,1));
% we need to estimate gamma, w, mu, and covariance
Y = [];
max_LL = -inf;
marker=['r*', 'go', 'b+', 'yv', 'ms'];
f =  figure('Name','EM of GMM');
hold on;
title('GMM with EM: Log-Likelihood');
xlabel('Iterations');
ylabel('Log Likelihood');

for i=1:5
    %initialize mu
    [clusters, mu] = kmeans(blob, k);
    % guess theta
    cov_1 = cov(blob);
    cov_2 = cov(blob);
    cov_3 = cov(blob);
    cov_k = {cov_1; cov_2; cov_3};
    mean = {mu(1,:); mu(2,:); mu(3,:)};
    random_w = rand(3,1);
    w = random_w./sum(random_w,1);
    gamma = zeros(N,k);
    convergence = false;
    iterations = 1;
    while(iterations <= 30)
        iterations = iterations+1;
        %  E Step use the guessed theta to claculate the gamma
        for j = 1:N
            data_set = {blob(j,:);blob(j,:);blob(j,:)};
%             marginal_dist = w.*arrayfun(mvnpdf, data_set, mean, cov_k);
            marginal_dist =   w(1)*mvnpdf(blob(j,:), mean{1}, cov_k{1})...
                            + w(2)*mvnpdf(blob(j,:), mean{2}, cov_k{2})...
                            + w(3)*mvnpdf(blob(j,:), mean{3}, cov_k{3});
            for m=1:k
                gamma(j,m) = w(m)*mvnpdf(blob(j,:), mean{m}, cov_k{m})/marginal_dist;
            end
        end
        %M Step use the above values to maximize mean and covariance 
        mean_new = cell(3,1);
        for m=1:k
%             t = repmat( gamma(:,k),1,2 );
%             t1 = sum( repmat( gamma(:,k),1,2 ).*blob(:,:), 1 );
            mean_new{m} = ( sum( repmat( gamma(:,m),1,2 ).*blob(:,:), 1 ) )./sum(gamma(:,m),1);
        end
%         sum = 0;
%         for m=1:k
%             s1 = (sum(mean_new{m}-mean{m}, 2));
%             s2 = (sum(mean_new{m}-mean{m}, 1));
%             sum = sum + abs(sum(mean_new{m}-mean{m}, 2));
%             
%         end
%         if sum < 0.000001
%             convergence = true;
%         end
        for m=1:k
            covar = zeros(size(cov_k{1}));
            for n = 1:N
            covar = covar + ((blob(n,:) - mean{m})' * (blob(n,:) - mean{m})).*(gamma(n,m));
            end
            cov_k{m} = covar./sum(gamma(:,m),1);
        end
        % recompute the weights
        for m=1:k
            w(m)=sum(gamma(:,m),1)/N;
        end
        
        % compute the log likelihood
        LL=0;
        for j=1:N
            p=0;
            for m=1:k
%                 cov_k{m}
                p = p + w(m) * mvnpdf(blob(j,:), mean{m}, cov_k{m});
            end
            LL = LL + log(p);
        end
        
        Y(iterations,i) = LL;
        
%         
%     convergence = true;    
    end
% plot here
    plot(1:30, Y(2:31,i), marker(i));    

    if max_LL < max(Y(:,i))
        ID = i;
        max_LL = max(Y(:,i));
        max_gamma = gamma;
        max_mean = mean;
        max_cov_k = cov_k;
        
    end

    
end

fprintf('\nThe best case is: %d', ID);

cluster_assignment = repmat(max(max_gamma,[],2),1,k)==max_gamma;
f1 = figure('Name', 'Cluster Assignment');
hold on;
title('Cluster Assignment from GMM');
for i = 1:N
    cluster = find(cluster_assignment(i,:)==1);
    if cluster==1
        plot(blob(i,1), blob(i,2), 'rx');
    elseif cluster==2
        plot(blob(i,1), blob(i,2), 'g.');
    else
        plot(blob(i,1), blob(i,2), 'b+');
    end
end

fprintf('\nThe mean and covariance for first distribution is: \n');
disp(max_mean{1});
disp(max_cov_k{1});
fprintf('\nThe mean and covariance for second distribution is: \n');
disp(max_mean{2});
disp(max_cov_k{2});
fprintf('\nThe mean and covariance for third distribution is: \n');
disp(max_mean{3});
disp(max_cov_k{3});
