clear
close all
load cancer
Xtrain=X(:,184:683);
Ytrain=label(:,184:683);
Xtest=X(:,1:183);
Ytest=label(:,1:183);
n=500;
T=1000;
p=zeros(1,n);
p11=zeros(1,T);
p22=zeros(1,T);
p33=zeros(1,T);

for i=1:n
    p(i)=1/n;
end
step=0.1;
test_size=183;
train_error=zeros(1,T);
test_error=zeros(1,T);
alpha_=zeros(1,T);
phi_=zeros(1,T);
train=zeros(n,T);
test=zeros(test_size,T);
w=[0,0,0,0,0,0,0,0,0,0]';
for t=1:T
    p11(t)=p(100);
    p22(t)=p(80);
    p33(t)=p(400);
    %c=p1(n,p);
    c=randsample(n,n,true,p);
   
    for i=1:n
        w=w+step*(1-1/(1+exp(-Ytrain(c(i))*Xtrain(:,c(i))'*w)))*Ytrain(c(i))*Xtrain(:,c(i));
    end
    phi=0;
    for i=1:n
        if sign(Xtrain(:,i)'*w)~=Ytrain(i)
            phi=phi+p(i);
        end
    end
    phi_(t)=phi;
    alpha=0.5*log((1-phi)/phi);
    alpha_(t)=alpha;
    normal=0;
    for i=1:n
        p(i)=p(i)*exp(-alpha*Ytrain(i)*sign(Xtrain(:,i)'*w));
        normal=normal+p(i);
    end
    for i=1:n
        p(i)=p(i)/normal;
    end
    train_count=0;
    for i=1:n
        if t==1
            train(i,1)=alpha*sign(Xtrain(:,i)'*w);
        else
            train(i,t)=alpha*sign(Xtrain(:,i)'*w)+train(i,t-1);
        end
        if Ytrain(i)~=sign(train(i,t))
            train_count=train_count+1;
        end
    end
    train_error(t)=train_count/n;
    test_count=0;
    for i=1:test_size
        if t==1
            test(i,1)=alpha*sign(Xtest(:,i)'*w);
        else
            test(i,t)=alpha*sign(Xtest(:,i)'*w)+test(i,t-1);
        end
        if Ytest(i)~=sign(test(i,t))
            test_count=test_count+1;
        end
    end
    test_error(t)=test_count/test_size;
end
figure
plot(train_error,'*')
hold on
plot(test_error,'ro')
% figure
% plot(alpha_,'ro')
% figure
% plot(phi_,'ro')
% figure
% plot(p11,'k*')
% hold on
% plot(p22,'ro')
% hold on
% plot(p33,'bs')
