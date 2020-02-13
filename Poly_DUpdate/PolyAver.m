clear
n = 20;
k = 300;
meDS = [];

for i=1:k
    [T, eDS, L, Q] = poly_figure2(n);
    clear KK TT
    for j=1:9
        KK(j) = min(abs(eDS{j}));
    end
    meDS = [meDS;KK];
    
end
meDSav = sum(meDS)./k;