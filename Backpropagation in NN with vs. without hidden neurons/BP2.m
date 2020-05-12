function [Cvt,Cvv]= BP2
eta=0.02; % Learning rate
beta=0.5;
iter=1000000;
% [thresholds,Thresholds,weightMatrix,WeightMatrix]=BPsetup2;
% w=weightMatrix;
% W=WeightMatrix;
patterns=ImportData; % Patterns are stored in rows
valid=ImportData2; % Patterns are stored in rows
inpat=300; % Number of input patterns
N= 2; % Dimension of input patterns
n= 4; % Number of hidden neurons
M= 1; % Dimension of output patterns
b=zeros(inpat,n);
bv=zeros(200,n);
B=zeros(inpat,M);
Bv=zeros(200,M);
O=zeros(inpat,M); % The output layer
Ov=zeros(200,M); % The output layer
deltaw=zeros(n,N);
deltaW=zeros(M,n);
deltai=zeros(inpat);
deltaj=zeros(inpat);
deltathreshold=zeros(inpat,n);
deltaThreshold=zeros(inpat,M);
H=zeros(iter/1,2); % Energy
V=zeros(inpat,n);
Vv=zeros(200,n);
Cvt=zeros(10,1);
Cvv=zeros(10,1);

patterns(:,1)=patterns(:,1)-mean(patterns(:,1));
patterns(:,1)=patterns(:,1)/std(patterns(:,1));
patterns(:,2)=patterns(:,2)-mean(patterns(:,2));
patterns(:,2)=patterns(:,2)/std(patterns(:,2));
valid(:,1)=valid(:,1)-mean(valid(:,1));
valid(:,1)=valid(:,1)/std(valid(:,1));
valid(:,2)=valid(:,2)-mean(valid(:,2));
valid(:,2)=valid(:,2)/std(valid(:,2));
for exp=1:10
   b=zeros(inpat,n);
bv=zeros(200,n);
B=zeros(inpat,M);
Bv=zeros(200,M);
O=zeros(inpat,M); % The output layer
Ov=zeros(200,M); % The output layer
deltaw=zeros(n,N);
deltaW=zeros(M,n);
deltai=zeros(inpat);
deltaj=zeros(inpat);
deltathreshold=zeros(inpat,n);
deltaThreshold=zeros(inpat,M);
H=zeros(iter/1000,2); % Energy
V=zeros(inpat,n);
Vv=zeros(200,n);
[thresholds,Thresholds,weightMatrix,WeightMatrix]=BPsetup2;
w=weightMatrix;
W=WeightMatrix;

pp=1;
for a=1:iter
    mu=ceil(300*rand);
    nu=ceil(200*rand);
    b(mu,:)=0;
    bv(mu,:)=0;
    for j=1:n
        for k=1:N
            b(mu,j)=b(mu,j)+w(j,k)*patterns(mu,k);
            bv(nu,j)=bv(nu,j)+w(j,k)*valid(nu,k);
        end
        b(mu,j)=b(mu,j)-thresholds(j);
        bv(nu,j)=bv(nu,j)-thresholds(j);
        V(mu,j)=tanh(beta*b(mu,j));
        Vv(nu,j)=tanh(beta*bv(nu,j));
    end
    
    for i=1:M
        B(mu,i)=0;
        Bv(nu,i)=0;
        for j=1:n
            B(mu,i)=B(mu,i)+W(i,j)*V(mu,j);
            Bv(nu,i)=Bv(nu,i)+W(i,j)*Vv(nu,j);
        end
        B(mu,i)=B(mu,i)-Thresholds(i);
        O(mu,i)=tanh(beta*B(mu,i));
        Bv(nu,i)=Bv(nu,i)-Thresholds(i);
        Ov(nu,i)=tanh(beta*Bv(nu,i));
    end
    
    deltaj(mu,:)=0;
    for i=1:M
        deltai(mu,i)=(patterns(mu,3)-O(mu,i))*(beta*(1-(tanh(beta*B(mu,i)))^2));
        for j=1:n
            deltaj(mu,j)=deltaj(mu,j)+deltai(mu,i)*W(i,j)*(beta*(1-(tanh(beta.*b(mu,j))).^2));
            deltaW(i,j)=eta*deltai(mu,i)*V(mu,j);
            for k=1:N
                deltaw(j,k)=eta*deltaj(mu,j)*patterns(mu,k);
            end
            deltathreshold(j)=-eta*deltaj(mu,j);
        end
        deltaThreshold(i)=-eta*deltai(mu,i);
    end

    for i=1:M
        for j=1:n
            W(i,j)=W(i,j)+deltaW(i,j);
            for k=1:N
                w(j,k)=w(j,k)+deltaw(j,k);
            end
            thresholds(j)=thresholds(j)+deltathreshold(j);
        end
        Thresholds(i)=Thresholds(i)+deltaThreshold(i);
    end
    if a==pp*1000
        H(pp,2)=sum(0.5.*(valid(:,3)-Ov).^2); % energy of validation set
        H(pp,1)=sum(0.5.*(patterns(:,3)-O).^2); % energy of training set
        pp=pp+1;
    end
end
Cvt(exp)=1/(2*300)*sum(abs(patterns(:,3)-sign(O)));
Cvv(exp)=1/(2*300)*sum(abs(valid(:,3)-sign(Ov)));
x=1:(iter/1000);
x=x';
plot(x,H(:,1),'b',x,H(:,2),'r'); hold on;
title('H=f(time)');
legend('Energy of training set - 10 runs','Energy of validation set - 10 runs','Location','southeast');
xlabel('Time');
ylabel('Energy');
end
end
