function [Q2, R2, R3, a2diff, gm] = matrix_rank_reduction(a55, alpha1, alpha2, digit1, digit2, digit3) ;

   % function [Q2, R2, R3, a2diff, gm] = matrix_rank_reduction(a55, alpha1, alpha2) ;
   % a2set    = Q2  * R2 ;      % rank reduced matrix
   % a2filter = R3' * R3 ;
   % a2filter = a2filter / norm(a2filter) ;
   % ggcorr   = gm * ones(1, nn3) ;
   % a2egg    = a2diff + ggcorr ;
   % [] = fun(a55_matrix, alpha1_tune, alpha2_work, digit1=512, digit2=2048, digit3=256) 
   
   mode1 = 0 ;   % matrix rank reduction
   mode2 = 1 ;   % inverse computation 
   
   alpha_tune = alpha1 ; 
   alpha_work = alpha2 ;
   
   a1 = a55 ;
   nn3 = size(a55, 1) ;
   
   a1max = max(max(a1)) ;
   a1min = min(min(a1)) ;
   a1mean = 0.5 * (1.0 * a1max + 1.0 * a1min) ;  % in case of centerized circle

   a11 = a1 - a1mean ;
   norma11 = norm(a11) ;

   a1set = a11 / norma11 ;

   spanmode = 0 ;  % (0=A*A'*A, 1=Lagrangian)
   a2set = rank_shift(spanmode, mode1, a1set, alpha_tune) ;  % mode1 = 0 is suitable for lower rank_reduction

   nnk = rank(a2set) ;
   a2inv = quad4inv(0, mode2, a2set, alpha_work) ;  % mode2 = 1 is good for inverse computation

   [Q, R1] = qr(a2inv) ;
   [Q1, R11] = qr(R1 * a2set) ;
   Q2 = Q * Q1 ;
   R3 = Q2' ;  % confirmed     % R3 = R2 ; no-good

   R3(nnk+1:nn3,:) = 0 ;    % [R3] 
   R3 = round(R3 * digit3) / digit3 ;  % digit3 = 256
   
   a2filter = R3' * R3 ; % a2inv * a2 ;
   a2filter = a2filter / norm(a2filter) ;

   a55pop = (a2filter * a55')' ;
   
   [Q, R] = qr(a55pop) ;
   Q2 = round(Q * digit1) / digit1 ;   % digit1 = 512
   R2 = round(R * digit2) / digit2 ;   % digit2 = 2048
   % a2set = Q2 * R2 ;

   a22corr = (a55' - a2filter * a55')' ;  % original signal dependent strip pattern
   gm      = mean(a22corr')' ;
   ggcorr  = gm * ones(1, nn3) ;
   a2diff  = a22corr - ggcorr ;

   % a2egg = ggcorr + a22diff ;

end


