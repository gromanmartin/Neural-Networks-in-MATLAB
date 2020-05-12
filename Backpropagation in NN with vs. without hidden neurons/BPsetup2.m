function [thresholds,Thresholds,weightMatrix,WeightMatrix] =BPsetup2
% Function for assigning weights and thresholds at the start of the program

N=2; % Dimension of input patterns
M=1; % Dimension of output patterns
H=4; % Number of hidden neurons
T=zeros(300,M); %  Big thresholds
t=zeros(300,H); % Small thresholds
w=zeros(M,N); % small weights
W=zeros(M,N); % big weights
T=-1+2*rand; % big thresholds

for j=1:H
    t(j)=-1+2*rand;% small thresholds
end

for k=1:N
    for j=1:H
        w(j,k)=-1/5+2/5*rand; % small weights
    end     
end

for j=1:H
    for i=1:M
        W(i,j)=-1/5+2/5*rand; % big weights
    end
end

thresholds=t;
Thresholds=T;
WeightMatrix=W;
weightMatrix=w;
end