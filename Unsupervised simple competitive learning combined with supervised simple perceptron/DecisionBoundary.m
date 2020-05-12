function [ out ] = DecisionBoundary(k,w,W,threshold)
iter=3*10^5;
beta=0.5;
p=20000;
O=zeros(p);
helpsum=zeros(k,1);
g=zeros(p,k);

patterns=zeros(p,3);
patterns(:,1)=50*rand(p,1)-20;
patterns(:,2)=25*rand(p,1)-10;

% --- COMPETITIVE LEARNING --- %
for i=1:p
    for c=1:k
        helpsum(c)=exp((-(norm(patterns(i,1:2)-w(c,1:2)))^2)/2);
    end
    helpsum=sum(helpsum);
    for j=1:k   
        g(i,j)=(exp((-(norm(patterns(i,1:2)-w(j,1:2)))^2)/2))/(helpsum);
    end
end
% --- SUPERVISED SIMPLE PERCEPTRON NETWORKS --- %
for i=1:iter
    mu=randi(p);    
    b=(g(mu,1:k)*W(1:k,1))-threshold;
    O(mu)=tanh(beta*b);
end
patterns(:,3)=O(:,1);
out=patterns;
end

