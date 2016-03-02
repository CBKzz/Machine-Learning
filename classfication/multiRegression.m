%multiclass logistic regression classiﬁer
%This one is difficult to handle. The log likelyhood function didn't converge until I modified the stepsize. And the accuracy is 87%
clear
load mnist_mat
attach=ones(5000,1);
Xt=[Xtrain',attach]';
attachh=ones(500,1);
Xtt=[Xtest',attachh]';
d=20;
w=zeros(d+1,10);%initialize
T=1000;
L=zeros(1,T);
Tm=zeros(5000,10);
for n=1:5000
    Tm(n,label_train(n)+1) =1; 
end
for t=1:T
    for j=1:10
        a=0;
        for i=1:5000
            sum=0;
            for k=1:10
                sum=sum+exp(Xt(:,i)'*w(:,k));
            end
            cbk=Tm(i,j)-exp(Xt(:,i)'*w(:,j))/sum;
            a=a+cbk*Xt(:,i);
        end
        w(:,j)=w(:,j)+0.1/50*a;
    end
    %L(t)
    for n=1:5000
        sum=0;
        for k=1:10
            sum=sum+exp(Xt(:,i)'*w(:,k));
        end
        for k=1:10
          if Tm(n,k)~=0
              L(t)=L(t)+log(exp(Xt(:,i)'*w(:,k))/sum);
          end
        end
    end
end
C=zeros(10,10);
for i=1:500
    lab=zeros(1,10);
    for j=1:10
        lab(j)=exp(Xtt(:,i)'*w(:,j));
    end 
    index=(find(lab==max(lab)));
    C(label_test(i)+1,index)=C(label_test(i)+1,index)+1;
end

re=zeros(10,3);
for j=1:10
    re(j,1)=exp(Xtt(:,59)'*w(:,j));
    re(j,2)=exp(Xtt(:,291)'*w(:,j));
    re(j,3)=exp(Xtt(:,403)'*w(:,j));
end
b=zeros(1,3);
for i=1:10
    b=b+re(i,:);
end
for i=1:3
    re(:,i)=re(:,i)./b(i);
end
subplot(1,3,1)
imagesc(reshape(Q*Xtest(:,59),28,28))
subplot(1,3,2)
imagesc(reshape(Q*Xtest(:,291),28,28))
subplot(1,3,3)
imagesc(reshape(Q*Xtest(:,403),28,28))
