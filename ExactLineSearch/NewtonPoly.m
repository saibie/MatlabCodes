function Ss = NewtonPoly(A, X0, class, maxiter, tol, LS_iter, alpha)
    % A 사이즈 체크
    m = size(A);
    if size(m) ~= 3
        error('A는 3-order Tensor이어야 합니다.'); end
    n = m(3) - 1;
    m = m(1);

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
    
    if nargin < 6
        LS_iter = 6; end
    
    if nargin < 7
        alpha = .5; end
    
    lamb = [];
    % cell들 초기화
    Xs = cell(1,maxiter+1); Xs{1} = X0;
    P_Xs = cell(1,maxiter+1);
    Hs = cell(1,maxiter);
%     S = zeros(m);
    
    iter = 0;
    P = Pnomial(X0, A);
    err = norm(P, 'fro');
    errs = zeros(1,maxiter+1); errs(1) = err;
    
    % Start Newton Iteration
    tic;
    while (err > tol) && (iter < maxiter)
        P_X = zeros(m^2); % P_X 계산
        for k = 1:n
            for l = 0:k-1
                P_X = P_X + kron(X0.'^(k-l-1), A(:,:,k+1)*X0^l);
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
            errs(iter+2) = err;
            
        elseif strcmp(class, 'Kelley')
            if mod(iter, 2) == 0
                X0 = X0 - H;
            else
                X0 = X0 - (2 - (norm(H, 'fro')^alpha)) * H;
            end
            P = Pnomial(X0, A);
            err = norm(P, 'fro');
            
            Xs{iter+2} = X0;
            Hs{iter+1} = H;
            errs(iter+2) = err;
            
        elseif strcmp(class, 'Modified')
            X0 = X0 - 2*H;
            P = Pnomial(X0, A);
            err = norm(P, 'fro');
            if err <= tol
                Xs{iter+2} = X0;
                Hs{iter+1} = H;
                errs(iter+2) = err;
                break
            end
            X0 = X0 + H;
            P = Pnomial(X0, A);
            err = norm(P, 'fro');
            
            Xs{iter+2} = X0;
            Hs{iter+1} = H;
            errs(iter+2) = err;
            
        elseif strcmp(class, 'MLSearch')
            if iter ~= LS_iter
                X0 = X0 - H;
                P = Pnomial(X0, A);
                err = norm(P, 'fro')
            else
                pt = zeros(2*n + 1,1);
                for t = 1:(2*n + 1)
                    pt(t) = CoeffiLSearch(A, X0, -H, t);
                end
                pt = flip(pt);
%                 pt = pt/min(abs(pt));
                ptder = polyder(pt);
                critic = roots(ptder);
                val = polyval(pt, critic);
                val = val(critic >= 1 & critic <= 2);
                [~, argminval] = min(abs(val));
                if isempty(val)
                    lamb = 1;
                else
                    lamb = real(critic(argminval));
                end
                
                X0 = X0 - lamb * H;
                P = Pnomial(X0, A);
                err = norm(P, 'fro');
            end
            
            if err <= tol
                Xs{iter+2} = X0;
                Hs{iter+1} = H;
                errs(iter+2) = err;
                break
            end
            
            Xs{iter+2} = X0;
            Hs{iter+1} = H;
            errs(iter+2) = err;
            
        elseif strcmp(class, 'ELSearch')
            pt = zeros(2*n + 1,1);
            for t = 1:(2*n + 1)
                pt(t) = CoeffiLSearch(A, X0, -H, t);
            end
            pt = flip(pt);
%             pt = pt/min(abs(pt));
            ptder = polyder(pt);
            critic = roots(ptder);
            val = polyval(pt, critic);
            val = val(critic >= 1 & critic <= 2);
            [~, argminval] = min(abs(val));
            if isempty(val)
                lamb = 1;
            else
                lamb = real(critic(argminval));
            end
            
            X0 = X0 - lamb * H;
            P = Pnomial(X0, A);
            err = norm(P, 'fro');
                
            Xs{iter+2} = X0;
            Hs{iter+1} = H;
            errs(iter+2) = err;
            
        elseif strcmp(class, 'BLSInner')
            if iter ~= 0
                cs = (H(:)' * H0(:))/(norm(H)*norm(H0));
            else
                cs = 0;
            end
            
            if abs(cs - 1) > 1e-15
                X0 = X0 - H;
                H0 = H;
                P = Pnomial(X0, A);
                err = norm(P, 'fro');
            else
                B = zeros(size(A));
                for k = 0:n
                    for j = 0:k
                        B(:,:,j+1) = B(:,:,j+1) + A(:,:,k+1) * PHIX(X0, -H, k, j);
                    end
                end
                
                L1 = ones(m);
                L2 = 2 * L1;
                Lc = (L1 + L2) / 2;
                for i = 1:52
                    pc = ePnomial(Lc, B);
                    L1 = (pc > 0).*Lc + ~(pc > 0).*L1;
                    L2 = (pc <= 0).*Lc + ~(pc <= 0).*L2;
                    Lc = (L1 + L2) / 2;
                end
                lamb = min(Lc(:));
                
                X0 = X0 - lamb * H;
                P = Pnomial(X0, A);
                err = norm(P, 'fro');
            end
                
            Xs{iter+2} = X0;
            Hs{iter+1} = H;
            errs(iter+2) = err;
            
        elseif strcmp(class, 'BLSearch') % BisectionLineSearch
            if iter ~= LS_iter
                X0 = X0 - H;
                P = Pnomial(X0, A);
                err = norm(P, 'fro');
            
            else
                B = zeros(size(A));
                for k = 0:n
                    for j = 0:k
                        B(:,:,j+1) = B(:,:,j+1) + A(:,:,k+1) * PHIX(X0, -H, k, j);
                    end
                end
                
                L1 = ones(m);
                L2 = 2 * L1;
                Lc = (L1 + L2) / 2;
                for i = 1:52
                    pc = ePnomial(Lc, B);
                    L1 = (pc > 0).*Lc + ~(pc > 0).*L1;
                    L2 = (pc <= 0).*Lc + ~(pc <= 0).*L2;
                    Lc = (L1 + L2) / 2;
                end
                lamb = min(Lc(:));
                
                X0 = X0 - lamb * H;
                P = Pnomial(X0, A);
                err = norm(P, 'fro');
            end
            
            Xs{iter+2} = X0;
            Hs{iter+1} = H;
            errs(iter+2) = err;
            
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
            P_X = P_X + kron(X0.'^(k-l-1), A(:,:,k+1)*X0^l);
        end
    end
    P_Xs{iter+1} = P_X;
        
    Xs = Xs(1:iter+1);
    Hs = Hs(1:iter);
    errs = errs(1:iter+1);
    P_Xs = P_Xs(1:iter+1);
    
    S = Xs{length(Xs)}; % Solution
    
    % Vectorize of tildeX and Xii - Xi
    vSmX = cell(1,length(Xs)-1);
    vXmX = cell(1,length(Xs)-1);
    for i = 1:length(Xs)-1
        vSmX{i} = reshape(S - Xs{i}, m^2, 1);
        vXmX{i} = reshape(Xs{i+1} - Xs{i}, m^2, 1);
    end
    
    % cos 계산
    cSX = cell(1,length(vSmX)-1);
    cXX = cell(1,length(vSmX)-1);
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
    
    Ss = {S, Xs, P_Xs, Hs, errs, vSmX, vXmX, cSX, cXX, caltime, lamb, 'S, Xs, P_Xs, Hs, errs, vSmX, vXmX, cSX, cXX, caltime, lamb'};

end

