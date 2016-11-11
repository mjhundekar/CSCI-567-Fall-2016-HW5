function [ K ] = rbf_kernel( sig, X )
% K(x, x') = exp (- (x -x)^2) /2sigma^2)

n = size(X,1);
K = X*X' / sig^2;
d = diag(K);
K  =K - ones(n,1)*d'/2;
K = K - d*ones(1,n)/2;
K = exp(K);
end

