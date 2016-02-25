clear
load mnist_mat.mat
d=20;
C=zeros(10,10);
knn=5;
for i=1:500
    %compute every distance
    d=zeros(2,5000);
    for j=1:5000
    a=Xtest(:,i)-Xtrain(:,j);
    d(1,j)=sqrt(a'*a);
    d(2,j)=label_train(j);
    end
    [Y,I]=sort(d(1,:));
    dd=d(:,I);
    %k
    label=zeros(2,10);
for t=1:10
    label(1,t)=t;
end
    for k=1:knn
       label(2,dd(2,k)+1)= label(2,dd(2,k)+1)+1;
    end
    [Y,I]=sort(label(2,:));
    dd=label(:,I);
    C(label_test(i)+1,dd(1,10))=C(label_test(i)+1,dd(1,10))+1;
    if label_test(i)+1~=dd(1,10) 
        i;
        if i==11||i==166||i==448
            i;
            label_test(i)+1;
            dd(1,10);
        end
    end
end
