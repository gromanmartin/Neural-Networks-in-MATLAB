function [thresholds,weightMatrix] =BPsetup
% Function for assigning weights and thresholds at the start of the program
N=2; % Dimension of input patterns
M=1; % Dimension of output patterns
t=zeros(300,M); % Thresholds
w=zeros(M,N); % Weights

t=-1+2*rand;

for j=1:M
    for k=1:N
        w(j,k)=-1/5+2/5*rand;
    end     
end

thresholds=t;
weightMatrix=w;
end