function Compare1(A,Q,p)
hold on

m=length(A);
X0=eye(m);
[S, iter, res, t] = Jiepthroot4(A,Q,X0,p,1);
[V D] = eig(S);
s=min(eig(S));
a=norm(A,2);
d=(s^p-((a^2)/p)^(p/(p-1)))/(a^2);

for i=-10:0.01:10;
    for j=-10:0.01:10;
        Y0=[i,0;0,j];
        Y=V*(D+Y0)/V;
        if (d-0.01)<norm(Y-V*D/V,2) && norm(Y-V*D/V,'fro')<d
            plot(i,j,'-')
        end
    end
end
