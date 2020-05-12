function [out]=GeneratingPatterns(N,p)
A=[-1;1];                                   % Matrix used for randomly selecting +-1
pattern=zeros(N,p);                         % N-number of bits, p- number of patterns
for i=1:N
    for j=1:p
        pattern(i,j)= A(randi(numel(A)));   % Each pattern is stored in one column of a matrix
    end
end
out=pattern;
end