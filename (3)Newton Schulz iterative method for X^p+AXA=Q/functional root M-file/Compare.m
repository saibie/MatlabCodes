function Compare(p)
hold on
%A=[0.5 -0.45;0.45 0];
A=[0.2 0.4;0.05 0.25];
%A=rand(2)
Q=[1 0; 0 1];
I=eye(2);

[X, iter, res, t] = Jiepthroot3(A,Q,p,1);
Z=X;
[V D]=eig(X);

for i=-5:0.2:5;
    for j=-5:0.2:5;

        Y=[i,0;0,j];
        Y0=I+V*Y/V;

        [X, iter, res, t] = Jiepthroot4(A,Q,Y0,p,1);
        if iter<100
        if norm(X-Z)<1e-13;
            plot(i,j,'*');
        else 
            plot(i,j,'r*');
        end
        else
            plot(i,j,'k*');
        end
    end
end
