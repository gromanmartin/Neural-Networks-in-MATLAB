function [out]=HebbsRule(N, p, patternMatrix)
% Patterns will be stored in columns of matrix
W=zeros(N);% Matrix of weights
A=patternMatrix;
for mu=1:p
    pattern=A(:,mu);
    for i=1:N
        for j=1:N
            W(i,j)=W(i,j)+pattern(i)*pattern(j);
        end
    end
end
out=W/N;
end
