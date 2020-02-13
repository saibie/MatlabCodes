function [ker1inv] = quad4inv(nestmode, mode, ker11, alpha) ;

    % function [ker1inv] = quad4inv(nestmode, mode, ker11, alpha) ;
    % nestmode = 1 : (A'*A')^-1*A'
    % mode = selectable as follows:
    % mode = 1 : inverse computation of distortion compensation with ker41 = ker4 - alpha * J3 
    % mode = 0 : effective rank reduction with moderate ellimination process (alpha=0)
    
    type = 1 ; % 1 ;   % test results: type=1 formula shows the best method of rank reduction with mode=0
    if(mode==2) type = 0 ; end
    
    nn1 = size(ker11,1) ;
    
    J1 = 0.5 * [eye(nn1), fliplr(eye(nn1))] ;
    J2 = [eye(nn1); zeros(nn1)] ;
    J3 = fliplr(eye(2*nn1)) ;

    ker1max = max(max(abs(ker11))) ;  % this is so critical for preserving sparse component 
    
    ker1  = ker11 / ker1max ;
    ker2  = sqrt(1 - ker1.^2) ;
    ker4  = [ker1, fliplr(ker1); -flipud(ker2), flipud(fliplr(ker2))] ;
    
    ker4 = ker4 / norm(ker4) ;
    %%
    
    if(mode>=1) ker41 = ker4 - alpha * J3 ; end   % normal mode for inverse computation
    if(mode==0) ker41 = ker4 ; end                % rank_reduction process
    
    %%
    
    r4inv = rpinv(type, ker41, alpha) ;
     ker1inv = J1 * r4inv * J2 ;   % good inverse compuation
        
    if(nestmode==1)             % nested computation mode
        p1 = ker1inv * ker11 ;
        ker1inv = rpinv(type, p1,0) * ker1inv ;
    end
    
    ker1inv = ker1inv / norm(ker1inv * ker11) ;
    
end

function [ker1inv] = rpinv(type, ker1, alpha1) ;

     n1 = size(ker1, 1) ;
     alpha2 = 1e-6 ; % 1e-20;  % somehow... this must be determined from the given ker1_matrix

     [s3, v3, d3] = svd(ker1) ;
     vcc = diag(v3) ;
     
     for i=1:n1
        if(vcc(i) > alpha2)
           if(type==0)
               svv4   = (1 + alpha1 * (1 - alpha1) / (vcc(i).^2 + alpha1)) / (1 - 0.5 * alpha1) ; % previously used
               vd3(i) = vcc(i)^3 / (vcc(i)^2 + alpha1)^2 * svv4^2 ;
           elseif(type==1)
               vd3(i) = vcc(i)^3 / (vcc(i)^2 + alpha1)^4 * (vcc(i)^4 - alpha1^4) ;   %  invertible algebra  
           elseif(type==2) 
               vd3(i) = vcc(i)^3 / (vcc(i)^2 + alpha1)^4 * (vcc(i)^2 - alpha1^2)^2 ; %  strange 
           else
               vd3(i) = vcc(i)^3 / (vcc(i)^2 + alpha1)^2  ; % primitive but no good
           end
        else
            vd3(i) = 0 ;
        end
     end

     ker1inv = d3 * diag(vd3) * s3' ;
     ker1inv = ker1inv / norm(ker1inv * ker1) ;
         
end
