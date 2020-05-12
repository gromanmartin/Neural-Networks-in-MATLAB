function [avgCv,minimCv,weights]=Combo
patterns=ImportData4;
p=2000; % Number of patterns
iter=10^5;
k=4;            % Number of Gaussian neurons
g=zeros(p,k);
eta=0.02;
w=zeros(k,2);
W=zeros(k,1);
beta=0.5;
eta2=0.1;
iter2=3000;
numofexp=20;         % Number of experiments
Cv=zeros(numofexp,1);
O=zeros(p,numofexp);
saveweight=zeros(k*numofexp,2);


for experiment=1:numofexp
    % --- INITIALISING WEIGHTS AND THRESHOLDS --- %
    threshold= -1+2*rand;
    for i=1:k
        w(i,1)= -1+2*rand;
        w(i,2)= -1+2*rand;
    end
    for i=1:k
        W(i,1)= -1+2*rand;
    end

    % --- UNSUPERVISED COMPETITIVE LEARNING --- %
    for i=1:iter
        deltaw=zeros(k,2);
        a=randi(p);
        helpsum=zeros(k,1);
        for c=1:k
            helpsum(c)=exp((-(norm(patterns(a,2:3)-w(c,1:2))).^2)./2);
        end
        helpsum=sum(helpsum);
        for j=1:k   
            g(a,j)=(exp((-(norm(patterns(a,2:3)-w(j,1:2)))^2)/2))/(helpsum);
        end
        [~,winner]=max(g(a,:));
        deltaw(winner,1:2)=eta*(patterns(a,2:3)-w(winner,1:2));
        w=w+deltaw;      
    end
    saveweight((k*experiment-(k-1)):(k*experiment),:)=w(1:k,:);
    
    % --- COMPETITIVE LEARNING --- %
    for i=1:p
        for c=1:k
            helpsum(c)=exp((-(norm(patterns(i,2:3)-w(c,1:2))).^2)./2);
        end
        helpsum=sum(helpsum);
        for j=1:k   
            g(i,j)=(exp((-(norm(patterns(i,2:3)-w(j,1:2)))^2)/2))/(helpsum);
        end
    end

    % --- SUPERVISED SIMPLE PERCEPTRON NETWORK --- %

    for i=1:iter2
        mu=randi(p);    
        b=(g(mu,1:k)*W(1:k,1))-threshold;
        O(mu,experiment)=tanh(beta*b);

        delta1=(patterns(mu,1)-O(mu,experiment))*(beta*(1-(tanh(beta*b))^2));    
        deltathreshold=-eta2*delta1;   
        deltaW=eta*delta1.*g(mu,1:k);

        W=W+deltaW';   
        threshold=threshold+deltathreshold;
    end
    for i=1:p
        b=(g(i,1:k)*W(1:k,1))-threshold;
        O(i,experiment)=tanh(beta*b);
    end
    Cv(experiment)=1/(2*p)*sum(abs(patterns(:,1)-sign(O(:,experiment))));
end

% --- RESULTS --- %
[~,minCv]=min(Cv);
a=1;
b=1;
for i=1:p
    if O(i,minCv)>0
        X(a,1)=patterns(i,2);
        X(a,2)=patterns(i,3);
        X(a,3)=O(i,minCv);
        a=a+1;
    elseif O(i,minCv)<0
        Y(b,1)=patterns(i,2);
        Y(b,2)=patterns(i,3);
        Y(b,3)=O(i,minCv);
        b=b+1;
    end
end
aa=1;
bb=1;
for i=1:p
    if patterns(i,1)==1
        XX(aa,1)=patterns(i,2);
        XX(aa,2)=patterns(i,3);
        aa=aa+1;
    else
        YY(bb,1)=patterns(i,2);
        YY(bb,2)=patterns(i,3);
        bb=bb+1;
    end
end


% --- GRAPHS --- %
boundary=DecisionBoundary(k,w,W,threshold);
figure

subplot(1,3,1)
scatter(X(:,1),X(:,2),4,X(:,3),'filled'); hold on;
scatter(Y(:,1),Y(:,2),4,Y(:,3),'filled'); hold on;
scatter(boundary(:,1),boundary(:,2),4,boundary(:,3),'filled'); 
title('Decision boundary')
xlabel('x1');
ylabel('x2');
colorbar;

subplot(1,3,2)
scatter(XX(:,1),XX(:,2),18,'green','filled'); hold on;
scatter(YY(:,1),YY(:,2),18,'red','filled'); hold on;
scatter(boundary(:,1),boundary(:,2),3,boundary(:,3),'filled'); 
title('Decision boundary with input data')
xlabel('x1');
ylabel('x2');
colorbar;

weights=saveweight((k*minCv-(k-1)):(k*minCv),:);
subplot(1,3,3)
plot(saveweight(:,1),saveweight(:,2),'b','Marker','.');
title('Weight vectors obtained after unsupervised learning')
xlabel('x1');
ylabel('x2');

% quiver(weights(1:4,1),weights(1:4,2));
% plot(weights(:,1),weights(:,2),'b','Marker','.');

minimCv=min(Cv);
avgCv=sum(Cv)/numofexp;
end