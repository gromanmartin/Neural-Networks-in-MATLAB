function [Cvt,Cvv]= BP
eta=0.02; % Learning rate
beta=0.5;
iter=1000000;
[thresholds,weightMatrix] =BPsetup;
w=weightMatrix; 
patterns=ImportData; % Patterns are stored in rows
valid=ImportData2; % Patterns are stored in rows
inpat=300; % Number of input patterns
N= 2; % Dimension of input patterns
M= 1; % Dimension of output patterns
b=zeros(inpat);
bv=zeros(inpat);
O=zeros(inpat,1); % The output layer
Ov=zeros(200,1); % The output layer
deltaw=zeros(M,N);
delta1=0;
deltathreshold=0;
patterns(:,1)=patterns(:,1)-mean(patterns(:,1));
patterns(:,1)=patterns(:,1)/std(patterns(:,1));
patterns(:,2)=patterns(:,2)-mean(patterns(:,2));
patterns(:,2)=patterns(:,2)/std(patterns(:,2));
valid(:,1)=valid(:,1)-mean(valid(:,1));
valid(:,1)=valid(:,1)/std(valid(:,1));
valid(:,2)=valid(:,2)-mean(valid(:,2));
valid(:,2)=valid(:,2)/std(valid(:,2));
H=zeros(iter/1000,2);
Cvt=zeros(10,1);
Cvv=zeros(10,1);

for exp=1:10
        k=1;
for a=1:iter
    mu=ceil(300*rand);
    nu=ceil(200*rand);
    b(mu)=sum(w.*patterns(mu,1:2))-thresholds;
    bv(nu)=sum(w.*valid(nu,1:2))-thresholds;
    O(mu)=tanh(beta*b(mu));
    Ov(nu)=tanh(beta*bv(nu));
    
    delta1=(patterns(mu,3)-O(mu))*(beta*(1-(tanh(beta*b(mu)))^2));    
    deltathreshold=-eta*delta1;   
    deltaw=eta*delta1.*patterns(mu,1:2);
    w=w+deltaw;   
    thresholds=thresholds+deltathreshold;

    if a==1000*k
        H(k,2)=sum(0.5.*(valid(:,3)-Ov).^2); % energy of validation set
        H(k,1)=sum(0.5.*(patterns(:,3)-O).^2); % energy of training set
        k=k+1;
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

