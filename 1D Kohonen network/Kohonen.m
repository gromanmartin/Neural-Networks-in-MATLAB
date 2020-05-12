function [out] = Kohonen
M=100; % Number of output neurons
Torder=1000;
Tconv=2*10^4;
sigma0=500000;
sigma=zeros(Torder,1);
sigmaconv=0.9;
eta=zeros(Torder,1);
etaconv=0.01;
eta0=0.1;
tausigma=300;
w=zeros(100,2);
deltaw=zeros(100,2);
A=zeros(M,1);
r=zeros(M,1);
zeta=GenerateKohonen;
competition=zeros(M,1);

% --- INITIALIZING --- %
for i=1:M
    r(i)=i;
end

for i=1:100
    for j=1:2
        w(i,j)=-1+2*rand;
    end
end

% --- ORDERING PHASE --- %
for t=1:Torder
    a=randi(1000);
    eta(t)=eta0*exp(-t/tausigma);
    sigma(t)=sigma0*exp(-t/tausigma);
    for i=1:M
        competition(i)=sqrt((zeta(a,1)-w(i,1))^2+(zeta(a,2)-w(i,2))^2);
    end   
    [~,winner]=min(competition);
    for i=1:M
        A(i)=exp((-abs(r(i)-r(winner))^2)/(2*(sigma(t))^2));
        deltaw(i,1)=eta(t)*A(i)*(zeta(a,1)-w(i,1));
        deltaw(i,2)=eta(t)*A(i)*(zeta(a,2)-w(i,2));
        w(i,1)=w(i,1)+deltaw(i,1);
        w(i,2)=w(i,2)+deltaw(i,2);
    end
end
W=w;

% --- CONVERGENCE PHASE --- %
for t=1:Tconv
    a=randi(1000);
    for i=1:M
        competition(i)=sqrt((zeta(a,1)-w(i,1))^2+(zeta(a,2)-w(i,2))^2);
    end   
    [~,winner]=min(competition);
    for i=1:M
        A(i)=exp((-abs(r(i)-r(winner))^2)/(2*sigmaconv^2));
        deltaw(i,1)=etaconv*A(i)*(zeta(a,1)-w(i,1));
        deltaw(i,2)=etaconv*A(i)*(zeta(a,2)-w(i,2));
        w(i,1)=w(i,1)+deltaw(i,1);
        w(i,2)=w(i,2)+deltaw(i,2);
    end
end

% --- RESULTS --- %
figure
subplot(1,2,1)       % add first plot in 2 x 1 grid
plot(W(:,1),W(:,2),'r','Marker','.');
title('Ordering phase')
xlabel('x1');
ylabel('x2');

subplot(1,2,2)       % add second plot in 2 x 1 grid
plot(w(:,1),w(:,2),'b','Marker','.');
title('Convergence phase')
xlabel('x1');
ylabel('x2');

end

