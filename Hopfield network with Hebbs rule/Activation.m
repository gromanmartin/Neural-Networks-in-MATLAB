function [out]=Activation(N,p,patternMatrix,weightMatrix)
W=weightMatrix;
S=zeros(N,p);
Snew=zeros(N,p);
act=zeros(1,N);
for mu=1:p
    pattern=patternMatrix(:,mu); % Each pattern is stored in specific column of matrix
    for j=1:N
        sum=zeros(1,N); % Help value, will be used for storing sums of S*W
        for i=1:N
            S(i,mu)=pattern(i); % Only renaming variables
            act(i)=S(i,mu)*W(i,j);
            sum(j)=sum(j)+act(i);
        end   
        
        if sum(j)>=0 % Decide whether the neuron is active or inactive
            Snew(j,mu)=1;
        else
            Snew(j,mu)=-1;
        end
    end   
end
updatedMatrix=Snew;
out=updatedMatrix;
end
