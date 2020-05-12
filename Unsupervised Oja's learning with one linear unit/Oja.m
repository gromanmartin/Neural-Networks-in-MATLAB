function [wout,wnout,d,dn] = Oja
eta=0.001;
iter=2*10^4;
p=401; % Number of input patterns
N=2; % Dimension of input patterns
w=zeros(1,N);
wn=zeros(1,N);
pattern=ImportData3;
patternn(:,1)=pattern(:,1)-mean(pattern(:,1));
patternn(:,2)=pattern(:,2)-mean(pattern(:,2));
%scatter(pattern(:,1),pattern(:,2));
z=zeros(iter,1);
zn=zeros(iter,1);
w(1,1)= -1+2*rand;
w(1,2)= -1+2*rand;
wn(1,1)= -1+2*rand;
wn(1,2)= -1+2*rand;
C=zeros(2);
C(1,1)=sum(pattern(:,1)'*pattern(:,1));
C(1,2)=sum(pattern(:,1)'*pattern(:,2));
C(2,1)=sum(pattern(:,2)'*pattern(:,1));
C(2,2)=sum(pattern(:,2)'*pattern(:,2));
C=C/p;
Cn(1,1)=sum(patternn(:,1)'*patternn(:,1));
Cn(1,2)=sum(patternn(:,1)'*patternn(:,2));
Cn(2,1)=sum(patternn(:,2)'*patternn(:,1));
Cn(2,2)=sum(patternn(:,2)'*patternn(:,2));
Cn=Cn/p;

for i=1:iter
    a=randi(p);
    b=randi(p);
    zeta=w(1,1)*pattern(a,1)+w(1,2)*pattern(a,2);
    zetan=wn(1,1)*patternn(b,1)+wn(1,2)*patternn(b,2);
    
    deltaw1=eta*zeta*(pattern(a,1)-zeta*w(1,1));
    deltawn1=eta*zetan*(patternn(b,1)-zetan*wn(1,1));
    deltaw2=eta*zeta*(pattern(a,2)-zeta*w(1,2));
    deltawn2=eta*zetan*(patternn(b,2)-zetan*wn(1,2));
    
    w(1,1)=w(1,1)+deltaw1;
    w(1,2)=w(1,2)+deltaw2;
    wn(1,1)=wn(1,1)+deltawn1;
    wn(1,2)=wn(1,2)+deltawn2;
    
    z(i)=norm(w);
    zn(i)=norm(wn);
end
x=1:iter;
x=x';
wg=[0 0; w(1) w(2)];
wgn=[0 0; wn(1) wn(2)];
% [V,D] = eigs(C,1);
% [Vn,Dn] = eigs(Cn,1);
% d=V;
% dn=Vn;
% wout=w;
% wnout=wn;

figure

subplot(2,2,1)       % add first plot in 2 x 2 grid
plot(x,z);
title('|w|=f(iter) (non-normalized data)')
xlabel('Number of iterations');
ylabel('|w|');

subplot(2,2,2)       % add first plot in 2 x 2 grid
plot(x,zn);
title('|w|=f(iter) (normalized data)')
xlabel('Number of iterations');
ylabel('|w|');

subplot(2,2,3)       % add first plot in 2 x 2 grid
scatter(pattern(:,1),pattern(:,2),2,'filled'); hold on;
plot(wg(:,1),wg(:,2),'LineWidth',2);
title('Weight vector visualized (non-normalized data)')
xlabel('x1');
ylabel('x2');

subplot(2,2,4)       % add first plot in 2 x 2 grid
scatter(patternn(:,1),patternn(:,2),2,'filled'); hold on;
plot(wgn(:,1),wgn(:,2),'LineWidth',2);
title('Weight vector visualized (normalized data)')
xlabel('x1');
ylabel('x2');

% subplot(3,2,5)       % add first plot in 2 x 2 grid
% plot(x,z);
% title('|w|=f(iter) (non-normalized data)')
% xlabel('Number of iterations');
% ylabel('|w|');
% 
% subplot(3,2,6)       % add first plot in 2 x 2 grid
% plot(x,zn);
% title('|w|=f(iter) (normalized data)')
% xlabel('Number of iterations');
% ylabel('|w|');
end

