function Ss = NewtonPoly(A, X0, class, maxiter, tol)
    % A 사이즈 체크
    m = size(A);
    if size(m) ~= 3
        error('A는 3-order Tensor이어야 합니다.'); end
    n = m(1) - 1;
    m = m(2);

    % X0 초기화
    if nargin < 2
        X0 = zeros(m); end

    % class 초기화
    if nargin < 3
        class = 'Pure'; end
    
    % maxiter 초기화
    if nargin < 4
        maxiter = 100; end
    
    % tol 초기화
    if nargin < 5
        tol = m * 1e-15; end
    
    % cell들 초기화
    Xs = cell(maxiter+1); Xs{1} = X0;
    P_Xs = cell(maxiter+1);
    Hs = cell(maxiter);
%     S = zeros(m);
    
    iter = 0;
    P = Pnomial(X0, A);
    err = norm(P, 'fro');
    errs = cell(maxiter+1); errs{1} = err;
    
    % Start Newton Iteration
    tic;
    while (err > tol) && (iter < maxiter)
        P_X = zeros(m^2); % P_X 계산
        for k = 1:n
            for l = 0:k-1
                P_X = P_X + kron(X0.'^(k-l-1), A(k+1,:,:)*X0^l);
            end
        end
        P_Xs{iter+1} = P_X; % P_X 저장
        vP = P(:);
        h = P_X \ vP;
        H = reshape(h, m, m);
        
        if strcmp(class, 'Pure')
            % Next Newton Sequence
            X0 = X0 - H;
            P = Pnomial(X0, A);
            err = norm(P, 'fro');
            
            Xs{iter+2} = X0;
            Hs{iter+1} = H;
            errs{iter+1} = err;
        else
            printf('Not prepared method : pure method로 전환합니다.');
            iter = iter - 1;
            class = 'Pure';
        end
        
        iter = iter + 1;
    end
    caltime = toc;
    
    P_X = zeros(m^2); % P_X 계산
    for k = 1:n
        for l = 0:k-1
            P_X = P_X + kron(X0.'^(k-l-1), A(k+1,:,:)*X0^l);
        end
    end
    P_Xs{iter+1} = P_X;
        
    Xs = Xs{1:iter+1};
    Hs = Hs{1:iter};
    errs = errs{1:iter+1};
    P_Xs = P_Xs{1:iter+1};
    
    S = Xs{length(Xs)}; % Solution
    
    % Vectorize of tildeX and Xii - Xi
    vSmX = cell(maxiter);
    vXmX = cell(maxiter);
    for i = 1:length(Xs)
        vSmX{length(vSmX)+1} = reshape(S - Xs{i}, m^2, 1);
        vXmX{length(vXmX)+1} = reshape(Xs{i+1} - Xs{i}, m^2, 1);
    end

    % cos 계산
    cSX = cell(maxiter-1);
    cXX = cell(maxiter-1);
    for i = 1:length(vSmX)-1
        x1 = vSmX{i+1};
        y1 = vSmX{1};
        x2 = vXmX{i+1};
        y2 = vXmX{i};
        c1 = (x1'*y1) / (norm(x1, 2)*norm(y1,2));
        c2 = (x2'*y2) / (norm(x2, 2)*norm(y2,2));
        cSX{length(cSX)+1} = c1;
        cXX{length(cXX)+1} = c2;
    end
    
    Ss = {S, Xs, P_Xs, Hs, errs, vSmX, vXmX, cSX, cXX, caltime, 'S, Xs, P_Xs, Hs, errs, vSmX, vXmX, cSX, cXX, caltime'};

end

