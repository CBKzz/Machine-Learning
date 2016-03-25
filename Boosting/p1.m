
function c=p1(n,w)
w=w.*10^5;
c=zeros(1,n);
k=length(w);
CDF=zeros(1,k);
CDF(1)=w(1);
for i=2:k
    CDF(i)=CDF(i-1)+w(i);
end
for i=1:n        
    r=rand*10^5;
    for j=1:k
        if r<CDF(j)
            c(i)=j;
            break;
        end     
    end
end
end
