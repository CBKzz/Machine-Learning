clear
load('mnist_mat.mat')
d=20;
la=10;
mu=zeros(d,la);
sigma=zeros(d,d,la);
C=zeros(10,10);
for i=0:9
    sum=zeros(d,1);
    count=i*500;
    for j=count+1:count+500
            sum=sum+Xtrain(:,j);
    end
    mu(:,i+1)=sum./500;
    a=zeros(d,d);
    for j=count+1:count+500
        a=a+(Xtrain(:,j)-mu(:,i+1))*(Xtrain(:,j)-mu(:,i+1))';
    end
    sigma(:,:,i+1)=a./500;
end
for i=1:500
    label=zeros(1,10);
    for j=1:10
         label(j)=mvnpdf(Xtest(:,i),mu(:,j),sigma(:,:,j));
    end
    k=(find(label==max(label)));
    C(label_test(i)+1,k)=C(label_test(i)+1,k)+1;
    if(k~=label_test(i)+1) 
        i;
    end
end

re=zeros(10,3);
for j=1:10
         re(j,1)=mvnpdf(Xtest(:,59),mu(:,j),sigma(:,:,j));
end
for j=1:10
         re(j,2)=mvnpdf(Xtest(:,180),mu(:,j),sigma(:,:,j));
end
for j=1:10
         re(j,3)=mvnpdf(Xtest(:,315),mu(:,j),sigma(:,:,j));
end
b=zeros(1,3);
for i=1:10
    b=b+re(i,:);
end
for i=1:3
    re(:,i)=re(:,i)./b(i);
end