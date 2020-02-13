function CompareNewtonFigure(A,B,C)
hold on
grid on

[n,m]=size(A);
B=A\B;
C=A\C;
A=eye(n);
I = eye(n);


[X, time1, iter1] = SandK_QME_NM(A,B,C,1);
X=zeros(n);
x1=zeros(iter1,1);
for i=1:1:iter1+1;

                pert = norm( X^2 + B*X + C,'fro');
            
            x1(i)=log10(pert);
    
    
            D_X0 = kron(X',A) + kron(I, A*X) + kron(I,B) ;      
            vQ = reshape( -( X^2 + B*X + C) ,n^2,1) ;
            vH = D_X0 \ vQ ;
            H = reshape(vH,n,n) ;
            X = X + H ;

end

% [X, time2, iter2] = SandK_QME_NM(A,B,C,2);
% X=zeros(n);
% x2=zeros(iter2,1);
% for i=1:1:iter2;
% 
%             D_X0 = kron( I , I ) - kron( ((B+X)\C)' , inv(B+X) )  ;        
%             vQ = reshape( ( - (B+X)\C - X ) , n^2 , 1 );
%             vH = D_X0 \ vQ;            
%             H = reshape(vH,n,n);
%             X = X + H;    
%             pert = norm( -(B+X)\C - X,'fro');
% 
%             x2(i)=log10(pert);
% end 

[X, time3, iter3] = SandK_QME_NM(A,B,C,3);
X=zeros(n);
x3=zeros(iter3,1);
for i=1:1:iter3+1;

                pert = norm( -(B+X)\C - X,'fro');
            
            x3(i)=log10(pert);
            D_X0 = kron( I , I ) - kron( ((B+X)\C)' , inv(B+X) );                       % D_X    
            vQ = reshape( - inv(B+X)*( X^2 + B*X + C) , n^2 , 1 );
            vH = D_X0 \ vQ; 
            H = reshape(vH,n,n);    
            X = X + H; 
            d=min(abs(diag(X)));            
            X=-(B+X-d*I)\(C+d*X);

end 

    plot(x1,'or');
%     plot(x2,'-k');
    plot(x3,'*b');
    xlabel('Iteration number')
    ylabel('Residual')
    legend('pure Newton','Newton+diagonal update')