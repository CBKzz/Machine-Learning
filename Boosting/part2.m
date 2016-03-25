clear
close all
load cancer
Xtrain=X(:,184:683);
Ytrain=label(:,184:683);
Xtest=X(:,1:183);
Ytest=label(:,1:183);
n=500;
T=1000;
test_size=183;
p=zeros(1,n);
for i=1:n
    p(i)=1/n;
end
train_error=zeros(1,T);
test_error=zeros(1,T);
alpha_=zeros(1,T);
phi_=zeros(1,T);
train=zeros(n,T);
test=zeros(test_size,T);
www=zeros(n,10);
p11=zeros(1,T);
p22=zeros(1,T);
p33=zeros(1,T);
for t=1:T
    p11(t)=p(150);
    p22(t)=p(100);
    p33(t)=p(255);
    c=p1(n,p);
    sum0=zeros(9,1);
    count0=0;
    sum1=zeros(9,1);
    count1=1;
    for i=1:n
        temp=Xtrain(:,c(i));
        temp(1)=[];
        if Ytrain(c(i))==-1
            sum0=sum0+temp;
            count0=count0+1;
        else
            sum1=sum1+temp;
            count1=count1+1;
        end
    end
    mu0=sum0/count0;
    pi0=count0/n;
    mu1=sum1/count1;
    pi1=count1/n;
    sum=zeros(9,9);
    for i=1:n
        temp=Xtrain(:,c(i));
        temp(1)=[];
        if Ytrain(c(i))==-1
            sum=sum+(temp-mu0)*(temp-mu0)';
        else
            sum=sum+(temp-mu1)*(temp-mu1)';
        end
    end
    sigma=sum/n;
    w0=log(pi1/pi0)-0.5*(mu1+mu0)'*inv(sigma)*(mu1-mu0);
    w=inv(sigma)*(mu1-mu0);
    www(t,:)=[w0,w']';
    phi=0;
    for i=1:n
        if Ytrain(i)~=sign(Xtrain(:,i)'*[w0,w']')
            phi=phi+p(i);
        end
    end
    phi_(t)=phi;
    alpha=0.5*log((1-phi)/phi);
    alpha_(t)=alpha;
    for i=1:n
        p(i)=p(i)*exp(-alpha*Ytrain(i)*sign(Xtrain(:,i)'*[w0,w']'));
    end
    normal=0;
    for i=1:n
        normal=normal+p(i);
    end
    for i=1:n
        p(i)=p(i)/normal;
    end
    train_count=0;
    for i=1:n
        error_sum=0;
        if t==1
            train(i,1)=alpha*sign(Xtrain(:,i)'*[w0,w']');
        else
            train(i,t)=alpha*sign(Xtrain(:,i)'*[w0,w']')+train(i,t-1);
        end
        if Ytrain(i)~=sign(train(i,t))
            train_count=train_count+1;
        end
    end
    train_error(t)=train_count/n;
    test_count=0;
    for i=1:test_size
        error=0;
        if t==1
            test(i,1)=alpha*sign(Xtest(:,i)'*[w0,w']');
        else
            test(i,t)=alpha*sign(Xtest(:,i)'*[w0,w']')+test(i,t-1);
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
figure
plot(alpha_,'ro')
figure
plot(phi_,'ro')
figure
plot(p11,'k*')
hold on
plot(p22,'ro')
hold on
plot(p33,'bs')









