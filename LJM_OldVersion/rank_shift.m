function [k1ret, a1shift] = rank_shift(spanmode, mode, a1, alpha) 
    
    [ker1inv] = quad4inv(0, mode, a1, alpha) ;  % ring_constraint
    
    a1shift = a1 * ker1inv * a1 ;     % principal R-process (feature preservation)
    a1shift = a1shift / norm(a1shift) ;
    
    if(spanmode==1)        % alternative R-process
        
       a9shift = shift_span(mode, a1, alpha) ;
    
       check9 = norm(a9shift - a1) ;
       check1 = norm(a1shift - a1) ;
    
       if(check9 < check1) 
           a1shift = a9shift ; 
       end
       
    end
    
    [k1inv] = quad4inv(0, mode, a1shift, alpha) ;  % rank(k1inv) = rank(a1)
    
    k1ret = a1shift * k1inv * a1shift ;  % feature preservation
    
    k1ret = k1ret / norm(k1ret) ;
    
end

function [a1shift] = shift_span(mode, a1, alpha) 

   ker1inv = quad4inv(0, mode, a1, alpha) ;  % ring_constraint
   a1top = quad4inv(0, mode, ker1inv/norm(ker1inv), alpha) ;
   a1top = a1top / norm(a1top) ;
   a1zip = a1 - a1top ;
   norm1 = norm(a1zip) ;
   z1inv = quad4inv(0, mode, a1zip/norm1, alpha) ;  % ring_constraint
   a2zip = a1zip * z1inv * a1zip ;
   a1shift = a1top + norm1 * a2zip / norm(a2zip) ;
   % a1shift = a1shift * ker1inv * a1shift ;
   a1shift = a1shift / norm(a1shift) ;
   
end