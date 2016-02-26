clear
load data
T=1000;
[N,d]=size(X);
k=20;
%p=1
result=zeros(1,1000);
RMSE_1=zeros(1,1000);
L=0;
difference=zeros(1000,20);
for t=1:T
tempX=X;
tempy=y;
[idx,idx]=sort(rand(1,N));
%train
trainX=tempX(idx(1:N-k),:);
trainy=tempy(idx(1:N-k),:);
%test
tempX(idx(1:N-k),:)=[];
tempy(idx(1:N-k),:)=[];

%%yuan
wml=inv(trainX'*trainX)*trainX'*trainy;


    predicty=tempX*wml;
    
    difference(t,:)=-tempy+predicty;
   L=[L,(-tempy+predicty)'];


% w=(trainX'*trainX)^(-1)*trainX'*trainy;
% ccccc=w;
% 
% 
% RR=tempX*w-tempy;
% tttt=tempX*w;
% for cc=1:20
% L=[L,RR(cc)];
% end
% RR=RR.^2;
% 
% result(t)=sum(abs(tempX*w-tempy));
% result(t)=result(t)/20;
% RMSE_1(t)=sqrt(sum(RR)/20);
end
%mean(result)
%var(result)

L(:,1)=[];
 mu_1=sum(L)/20000
lam_1=0;
for cc=1:20000
    lam_1=lam_1+(L(cc)-mu_1)^2;
end
 lam_1=lam_1/20000
lh_1=0;
for cc=1:20000
    lh_1=lh_1+log(normpdf(L(cc),mu_1,lam_1));
end
uML=sum(sum(difference))/20000 %%mean value of the errors
sigmaML=0;
for i=1:20
    for n=1:1000
    sigmaML=sigmaML+(difference(n,i)-uML)^2;
    end
end
sigmaML=sigmaML/20000 %variance of the errors
loglikelihood=0;
for i=1:20
    for n=1:1000
        prob=normpdf(difference(n,i),uML,sigmaML);
        prob=log(prob);
        loglikelihood=loglikelihood+prob;
    end
end
loglikelihood

% %p=2
% L_2=0;
% result_2=zeros(1,T);
% RMSE_2=zeros(1,T);
% 
% for t=1:T
% tempX=X;
% tempy=y;
% [idx,idx]=sort(rand(1,N));
% %train
% trainX=tempX(idx(1:N-k),:);
% trainX_p=[trainX,trainX.^2];
% trainX_p(:,8)=[];
% trainy=tempy(idx(1:N-k),:);
% %test
% tempX(idx(1:N-k),:)=[];
% tempX_p=[tempX,tempX.^2];
% tempX_p(:,8)=[];
% tempy(idx(1:N-k),:)=[];
% 
% w=(trainX_p'*trainX_p)^(-1)*trainX_p'*trainy;
% RR=tempX_p*w-tempy;
% for cc=1:20
% L_2=[L_2,RR(cc)];
% end
% RR=RR.^2;
% RMSE_2(t)=sqrt(sum(RR)/20);
% result_2(t)=sum(abs(tempX_p*w-tempy))/20;
% end
% mean(RMSE_2)
% var(RMSE_2)
% L_2(:,1)=[];
% mu_2=sum(L_2)/20000
% lam_2=0;
% for cc=1:20000
%     lam_2=lam_2+(L_2(cc)-mu_2)^2;
% end
% lam_2=lam_2/20000
% lh_2=0;
% for cc=1:20000
%     lh_2=lh_2+log(normpdf(L_2(cc),mu_2,lam_2));
% end
% 
% %p=3
% result_3=zeros(1,T);
% RMSE_3=zeros(1,T);
% L_3=0;
% for t=1:T
% tempX=X;
% tempy=y;
% [idx,idx]=sort(rand(1,N));
% %train
% trainX=tempX(idx(1:N-k),:);
% trainX_p=[trainX,trainX.^2,trainX.^3];
% trainX_p(:,8)=[];
% trainX_p(:,14)=[];
% trainy=tempy(idx(1:N-k),:);
% %test
% tempX(idx(1:N-k),:)=[];
% tempX_p=[tempX,tempX.^2,tempX.^3];
% tempX_p(:,8)=[];
% tempX_p(:,14)=[];
% tempy(idx(1:N-k),:)=[];
% 
% w=(trainX_p'*trainX_p)^(-1)*trainX_p'*trainy;
% RR=tempX_p*w-tempy;
% for cc=1:20
% L_3=[L_3,RR(cc)];
% end
% RR=RR.^2;
% RMSE_3(t)=sqrt(sum(RR)/20);
% result_3(t)=sum(abs(tempX_p*w-tempy))/20;
% end
% mean(RMSE_3)
% var(RMSE_3)
% L_3(:,1)=[];
% mu_3=sum(L_3)/20000
% lam_3=0;
% for cc=1:20000
%     lam_3=lam_3+(L_3(cc)-mu_3)^2;
% end
% lam_3=lam_3/20000
% lh_3=0;
% for cc=1:20000
%     lh_3=lh_3+log(normpdf(L_3(cc),mu_3,lam_3));
% end
% 
% %p=4
% result_4=zeros(1,T);
% RMSE_4=zeros(1,T);
% L_4=0;
% for t=1:T
% tempX=X;
% tempy=y;
% [idx,idx]=sort(rand(1,N));
% %train
% trainX=tempX(idx(1:N-k),:);
% trainX_p=[trainX,trainX.^2,trainX.^3,trainX.^4];
% trainX_p(:,8)=[];
% trainX_p(:,14)=[];
% trainX_p(:,20)=[];
% trainy=tempy(idx(1:N-k),:);
% %test
% tempX(idx(1:N-k),:)=[];
% tempX_p=[tempX,tempX.^2,tempX.^3,tempX.^4];
% tempX_p(:,8)=[];
% tempX_p(:,14)=[];
% tempX_p(:,20)=[];
% tempy(idx(1:N-k),:)=[];
% 
% w=(trainX_p'*trainX_p)^(-1)*trainX_p'*trainy;
% RR=tempX_p*w-tempy;
% for cc=1:20
% L_4=[L_4,RR(cc)];
% end
% RR=RR.^2;
% 
% RMSE_4(t)=sqrt(sum(RR)/20);
% result_4(t)=sum(abs(tempX_p*w-tempy))/20;
% end
% mean(RMSE_4)
% var(RMSE_4)
% L_4(:,1)=[];
% mu_4=sum(L_4)/20000
% lam_4=0;
% for cc=1:20000
%     lam_4=lam_4+(L_4(cc)-mu_4)^2;
% end
% lam_4=lam_4/20000
% lh_4=0;
% for cc=1:20000
%     lh_4=lh_4+log(normpdf(L_4(cc),mu_4,lam_4));
% end
if a=1
    a
else