tx ='$';
for m=0:5
    if m==0
        tx = [tx,'\left('];
    else
        tx = [tx,'+\left('];
    end
    for i=0:m
        for j=0:m-i
            k = m-i-j;
            tx = [tx,sprintf('+\\frac{(-X)^{%d}}{2^{%d}{%d}!}\\frac{S^{%d}}{{%d}!}\\frac{(-X)^{%d}}{2^{%d}{%d}!}',i,i,i,j,j,k,k,k)];
%             fprintf('(%d, %d, %d)\n',i,j,k);
           
        end
    end
    tx = [tx,'\right)'];
end
tx = [tx,'$'];
