clear A m
m = 50;

A = MakeGenSingA(m, 8, .00001);
X0 = zeros(m);
maxiter = 100;
tol = m * 1e-15;
LS_iter = 6;
alpha = .5;

Ss = cell(1,6);
Ss{1} = NewtonPoly(A, X0, 'Pure', maxiter, tol, LS_iter, alpha);
Ss{2} = NewtonPoly(A, X0, 'Modified', maxiter, tol, LS_iter, alpha);
Ss{3} = NewtonPoly(A, X0, 'MLSearch', maxiter, tol, LS_iter, alpha);
% Ss{4} = NewtonPoly(A, X0, 'ELSearch', maxiter, tol, LS_iter, alpha);
Ss{5} = NewtonPoly(A, X0, 'BLSearch', maxiter, tol, LS_iter, alpha);
Ss{6} = NewtonPoly(A, X0, 'BLSInner', maxiter, tol, LS_iter, alpha);

fig = figure(1);
s = get(0, 'ScreenSize');
fig.Position= [0 0 s(3) s(4)];

ax = cell(1,6);
for i = 1:6
    ax{i} = subplot(2,3,i);
    if ~isempty(Ss{i})
        semilogy(ax{i}, [0:length(Ss{i}{5})-1], Ss{i}{5},'-o');
    end
    ax{i}.YLim = [1e-16 10];
    if i ~= 1
        ax{i}.XLim = ax{1}.XLim;
    end
end

