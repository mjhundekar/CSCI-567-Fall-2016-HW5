function [K] = gaussian_kernel( X, mu, sig )
K = [];
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% n = size(X,2);
% d = X - mu;
% s = std(X);
% C = 1/(det(s)*sqrt(2*pi));
% K = 1/(sqrt((2*pi)^n*det(s)))*exp(-0.5*sum(d*inv(s).*d,2));
    C = 1/(sqrt(2*pi*sig^2));
    for i=1:length(X)
        
         Sum = (X(i,:).^2).*-1;
         Sum = exp(Sum./(2*sig*sig)).*C;
         K = [K;Sum];
         
%         for j=1:length(X(i,:))
%             Sum = Sum + X(i,j)^2
%             Sum = exp(-Sum/(2*s*s))
%             val = val*Sum
%             
%         end
%         K = [k;Val]
end

