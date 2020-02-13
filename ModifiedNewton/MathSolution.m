% Define S1 : 'Real' Solution
n = 10;
delta = 0;
for l=1:n-1
    P1(l,l)=-1;
    P1(l+1,l)=1;
end
P = ones(n,1);
P = [P P1];
D = min(roots([1-sqrt(delta) -2-sqrt(delta) 1+2*sqrt(delta)]));
for l=2:n
    D(l,l) = max(roots([(-(1-sqrt(delta))/(3*(n-1))) (-(1-sqrt(delta))/(3*(n-1)))-1 (-(1-sqrt(delta))/(3*(n-1)))+sqrt(delta)]));
end
S1 = P*D*inv(P);