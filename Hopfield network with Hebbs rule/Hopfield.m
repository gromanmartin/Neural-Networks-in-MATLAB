function [out]=Hopfield(numberOfPatterns)
N=500;            % Number of neurons
p=numberOfPatterns;% Number of stored patterns
bits=0;           % Number of checked bits
counter=0;        % Number of flipped bits
cycles=ceil(100000/(p*N))+1;

for i=1:cycles
    patternMatrix = GeneratingPatterns(N,p);
    W = HebbsRule(N,p,patternMatrix);
    updatedMatrix = Activation(N,p,patternMatrix,W);
    for mu=1:p
        for j=1:N
            if updatedMatrix(j,mu)~=patternMatrix(j,mu)
                counter=counter+1;
            end
            if bits==100000
                break;
            end
            bits=bits+1;
        end
    end
    out=counter;
end
end