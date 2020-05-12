function StochasticHopfield()
N=200;
p=5;
time=100000;
beta=2;
iter=20;
avgm1=zeros(time,iter);

for a=1:iter
    patternMatrix=GeneratingPatterns(N,p);
    weightMatrix=HebbsRule2(N, p, patternMatrix);
    [op]=StochasticActivation2(N,time,beta,patternMatrix,weightMatrix);
    for i=1:(time)
        avgm1(i,a)=sum(op(1:i))/i;
    end
end
x=(1:time);
figure
for i=1:20
    plot(x,avgm1(:,i)); hold on;
end
title('m1(travel. mean)=f(time)');
legend('Curve 1','Curve 2','Curve 3','Curve 4','Curve 5','Curve 6','Curve 7','Curve 8','Curve 9','Curve 10','Curve 11','Curve 12','Curve 13','Curve 14','Curve 15', 'Curve 16','Curve 17','Curve 18','Curve 19','Curve 20','Location','southeast');
xlabel('Time');
ylabel('m1(travelling mean)');
end
