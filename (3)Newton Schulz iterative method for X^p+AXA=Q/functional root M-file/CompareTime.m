function B=CompareTime(A,n)

m=length(A);
Q=eye(m);
B=zeros(9,6);

for i=1:1:9;
t1=0;
iter1=0;
t2=0;
iter2=0;    
t3=0;
iter3=0;

for k=1:1:n;   
    [X, iter, res, t] = Jiepthroot3(A,Q,i+1,1);
    t1=t1+t;
    iter1=iter;
end

for k=1:1:n;
    [X, iter, res, t] = Jiepthroot3(A,Q,i+1,2);
    t2=t2+t;
    iter2=iter;
end

for k=1:1:n;
    [X, iter, res, t] = Jiepthroot3(A,Q,i+1,4);
    t3=t3+t;
    iter3=iter;
end

B(i,1)=t1/n;
B(i,2)=t2/n;
B(i,3)=t3/n;
B(i,4)=iter1;
B(i,5)=iter2;
B(i,6)=iter3;

end