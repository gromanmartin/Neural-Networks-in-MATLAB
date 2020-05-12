function [out] = GenerateKohonen
X=zeros(2000,2);
Y=zeros(2000,2);
for i=1:2000
    X(i,1)= rand;
    X(i,2)= rand;
end
a=1;
for i=1:2000
    if (~(X(i,1)>0.5 && X(i,2)<0.5))
        Y(a,1)=X(i,1);
        Y(a,2)=X(i,2);
        a=a+1;
    end
    if a==1000
        break;
    end
end
out=Y;
%scatter(Y(:,1),Y(:,2),10,'filled')
end
