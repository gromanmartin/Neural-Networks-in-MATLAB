function [op]=StochasticActivation2(N,time,beta,patternMatrix,weightMatrix)
W=weightMatrix;
b=zeros(N,1);
m1=zeros(time,1);
pattern=patternMatrix(:,1);                 % Choose the first pattern
S=pattern;                                  % Feed pattern(1)
for t=1:time
    a=ceil(200*rand);                       % Choose a random bit
    b(a)=0;
    for j=1:N       
        b(a)=b(a)+W(a,j)*S(j);              % Value of b for chosen bit
    end 
    g=(1/(1+exp(-2*beta*b(a))));            % Relation for g(b) of chosen bit
    P=[g (1-g)];                            % Matrix of probabilities
    X=[1 -1];                               % Possible values of S
    S(a)=X(find(rand<cumsum(P),1));         % Update a-th bit
   for i=1:N
        m1(t)=m1(t)+(S(i)*pattern(i));      % Relation for order parameter
    end    
end
op=m1/N;                                    % Divide each component by number of bits
end



