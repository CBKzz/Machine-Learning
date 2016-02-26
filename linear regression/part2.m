%load data
p=1; %%set exponential
display='%dth order polynomial regression';
fprintf(display,p);
A=X;
A(:,1)=[];
GG=A;
for i=2:p  %%assemble the new X matrix 
    B=A.^i;
    GG=horzcat(GG,B);
   
end
C=ones(392,1);
Xnew=horzcat(C,GG);
RMSE=zeros(1,1000);
difference=zeros(1000,20);
for n=1:1000
vector=randperm(392);
trainingx=zeros(size(Xnew));
trainingy=zeros(size(y));
testingx=zeros(20,length(Xnew(1,:)));
for i=1:392
    trainingx(i,:)=Xnew(vector(i),:);
    trainingy(i,:)=y(vector(i),:);
end
testingx(1:20, :)=trainingx(1:20,:);
precisey(1:20, :)=trainingy(1:20,:);
for i=1:20
    trainingx(1,:)=[];
    trainingy(1,:)=[];
end
wml=inv(trainingx'*trainingx)*trainingx'*trainingy;
AE=0;
for i=1:20
    predicty=(testingx(i,:))*wml;
    error=(predicty-precisey(i))^2;
    difference(n,i)=-precisey(i)+predicty;
    AE=AE+error;
end
RMSE(n)=sqrt(AE/20);
end
mean=sum(RMSE)/1000   %%mean value of RMSE
sumdev=0;
for i=1:1000
    deviation=(RMSE(i)-mean)^2;
    sumdev=sumdev+deviation;
end
SD=sqrt(sumdev/1000)  %%standard deviation of RMSE
histogram(difference)
uML=sum(sum(difference))/20000 %%mean value of the errors
sigmaML=0;
for i=1:20
    for n=1:1000
sigmaML=sigmaML+(difference(n,i)-uML)^2;
    end
end
sigmaML=sigmaML/20000 %variance of the errors
loglikelihood=0;
for i=20
    for n=1:1000
        prob=normpdf(difference(n,i),uML,sigmaML);
        prob=log(prob);
        loglikelihood=loglikelihood+prob;
    end
end
loglikelihood





       

       