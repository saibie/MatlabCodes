function [S, XX, DS, RE, Conv, Conv2, Conv3] = FP_Poly(A,X0,minp,maxiter,grph)

nA = size(A);
if nargin < 2
    X0 = zeros([nA(1) nA(2)]);
end
nX0 = size(X0);

if ~((nA(1)==nA(2))&(nX0(2)==nX0(1))&(nA(1)==nX0(1)))                     % Are the size of matrices right?
    disp('The size of A`s and X0 are not right. (by Polynomial)');
    return
else
    m = nA(1);
    if length(nA) < 3
        disp('We need more coefficient matrices. (by n = 1)');
        return
    else
        n = nA(3);
    end
end

if nargin < 4
    maxiter = 7000;
end

if nargin < 3
    minp = m*10^(-15);
    %minp = 10^(-16);
    %minp = 2^(-53);
    %minp = 0;
end

if nargin < 5
    grph = 1;
end

%Initialize
i = 1;
I = eye(m);
X{i} = X0;
pert = 1;

while (pert > minp) & (i < maxiter)
    X1 = -inv(A(:,:,2))*(Polynom(X0,A) - A(:,:,2)*X0);
    X{i+1} = X1;
    if i == 1
        RE(i) = 0;
    else
        RE(i) = norm(X1,'fro')/norm(X0,'fro');                                  % Relative Error
    end
    
    pert = norm(Polynom(X1,A),'fro');
    i = i + 1;
    X0 = X1;
        
end

if i >= maxiter
    fprintf('It doesn`t converges\n')
end

S = X1;
DS = zeros(m^2);
for j=2:n-1                                                               % DS
    for k=1:j
        DS = DS + kron(S^(j-k),inv(-A(:,:,2))*A(:,:,j+1)*S^(k-1));
    end
end
XX = X;
for j=1:i-1
    if norm((X{j}-S),'fro') == 0
        Conv(j) = 0;
    else
        Conv(j) = norm((X{j+1} - S),'fro') / norm((X{j} - S),'fro');
    end
    Conv2(j) = (norm((X{j} - S),'fro'))^(1/j);
    Conv3(j) = norm((Polynom(X{j},A)),'fro');
    Conv4(j) = norm((X{j} - S),'fro');
end

if grph == 1
    subplot(2,2,1)
    plot(Conv,'-*')
    t1 = title('${||\tilde{X_{i+1}}||} ~/~ {||\tilde{X_{i}}||}$');
    set(t1,'Interpreter','Latex');

    subplot(2,2,2)
    plot(Conv2,'-');hold on;plot(length(Conv2),max(abs(eig(DS))),'*r');hold off
    t2 = title('$\sqrt[i]{{||\tilde{X_{i}}||}}$');
    set(t2,'Interpreter','Latex');

    subplot(2,2,3)
    semilogy(Conv3,'-*')
    t3 = title('log${||Q(X_{i})||}$');
    set(t3,'Interpreter','Latex');

    subplot(2,2,4)
    semilogy(Conv4,'-*')
    t4 = title('log$({||X_{i+1}-S||}~ /~ {||X_{i+1}||})$');
    set(t4,'Interpreter','Latex');
end

end