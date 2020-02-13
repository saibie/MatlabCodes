
alpha_tune = 0.05  ;% 0.03  ; % 0.03 ; % 0.07 ; % 0.02
                    % rank=3  at alpha=0.05 & mode=0
alpha_work = 0.1 * alpha_tune ;
mode = 0 ;

digit1 = 256 * 4 ;
% digit2 = 256 / 1 ;

ns1 = 200 ;
ns2 = 200 ;
nn = 18 * 8 - 1 ;
% a55 = a5(9:80, 9:80) ;
 a55 = a5(ns1:4:ns1+nn, ns2:4:ns2++nn) ;

a55 = a55 / norm(a55) ;
a55max = max(max(a55)) ;
a55min = min(min(a55)) ;
a1set = a55 ;
a5set = a55 ;
nn3 = size(a55, 1) ;

%%

[Q2, R2, R3, a22diff, gm] = matrix_rank_reduction(a1set, alpha_tune, alpha_work, 512, 2048, 256) ;  % rank_reduction from a1set to a2

a2set    = Q2 * R2 ;
a2filter = R3' * R3 ; % a2inv * a2 ;
a2filter = a2filter / norm(a2filter) ;

a22diff = round(a22diff * 4096) / 4096 ;
a22wet  = round(a22diff*256)/256 ;

a22wet = a22wet / norm(a22wet) * norm(a22diff) ;

ggcorr   = gm * ones(1, nn3) ;
a2egg    = ggcorr + a22diff ;

nnk = rank(a2set) ;
U5  = [10*a22diff(1:4:nn3, 1:nn3) ; Q2(1:nn3,1:nnk)'/2; R2(1:nnk,1:nn3)*2; R3(1:nnk,1:nn3)/2; gm'] ;
nn4 = size(U5,1) ;
U61 = [U5; zeros(nn3-nn4, nn3)] ;
U6  = U61(1:nn3,1:nn3) ;

%%
factor = 0.0 ;  % a22diff is set at the best model (factor=1)  % norm is minimized at the right selection
a22trial = (1 - factor) * a22wet + factor * a22diff ;
g4sol    = a2set + ggcorr + a22trial  ;   % initial setting = true solution

%%

g4try = g4sol;
g2corr_try = 0 * g4sol ;

nnloop = 2 ;

for loop=1:nnloop   %  [R3, Q, R, ggcorr] & a2set_trial_true 
 
    g4try = g4try - g2corr_try ;
    g4try(g4try<a55min) = a55min ;
    g4try(g4try>a55max) = a55max ;
    g4try = g4try / norm(g4try) ;
    g2corr_try = (g4try' - a2filter * g4try')' - a2egg ;
     loop_check = [loop, norm(g2corr_try)]
     
end

g5sol = g4try ;
g5sol = g5sol / norm(g5sol) ;

%%

g55sol = rank_shift(0, 1, g5sol, 1e-6) ;  % further iteration check

g4try  = g55sol + 0 * a2egg;
g2corr_try = 0 * g4sol ;

nnloop = 2 ;

for loop=1:nnloop   %  [R3, Q, R, ggcorr] & a2set_trial_true 
 
    g4try = g4try - g2corr_try ;
    g4try(g4try<a55min) = a55min ;
    g4try(g4try>a55max) = a55max ;
    g4try = g4try / norm(g4try) ;
    g2corr_try = (g4try' - a2filter * g4try')' - a2egg ;
     loop_check = [loop, norm(g2corr_try)]
     
end

g6sol = g4try ;
g6sol = g6sol / norm(g6sol) ;

%%

norm_check = [norm(g4sol-a55), norm(g5sol - g4sol), norm(g5sol-a55), norm(g6sol-g5sol)]  % 
[mean(mean(abs(a55-g4sol))), mean(mean(abs(a55-g5sol))), mean(mean(abs(a22diff)))] * 256 / max(max(a55))

figure(1),
red_blue_image([0.05*U6, 0.02*sign(a2filter).*sqrt(abs(a2filter)); a2set, g4sol; (g5sol-g4sol), g5sol]) ;
title('MRIFF@SiNetGa_2015')

% figure(24),
% red_blue_image(a22diff) ;

% figure(29),
% red_blue_image([a55, a1set, a2set + ggcorr ; a22diff, g4sol, 4*(a55-g4sol)]) ;
     
% figure(30),
% imagesc([a55, g4sol; 2*(g5sol-g4sol), g5sol; g6sol, 8*(g6sol-g5sol)]) ;
% colormap('gray')