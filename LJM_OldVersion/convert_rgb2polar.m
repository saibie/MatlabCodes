function [h5, angle1, angle2] = convert_rgb2polar(ja4, offset)

     [nk1, nk2, nk3] = size(ja4) ;
     h5   = zeros(nk1, nk2) ;
     angle1 = zeros(nk1, nk2) ;
     angle2 = zeros(nk1, nk2) ;
 
     for k1=1:nk1
         for k2=1:nk2
             r1 = ja4(k1,k2,1) ;
             g1 = ja4(k1,k2,2) ;
             b1 = ja4(k1,k2,3) ;
             [hr, theta1, phi1] = convert_rgb2polar_pixel(r1, g1, b1, offset) ;
             h5(k1,k2)   = hr ;
             angle1(k1,k2) = theta1 ;
             angle2(k1,k2) = phi1 ;
         end
     end

return

function [hr, theta, phi] = convert_rgb2polar_pixel(r, g, b, alpha) 

    [kgray, color, phi] = color_phase(r,g,b, alpha) ;   % phi[0,1] for [0,2*pi]
    
    theta = atan2(color, kgray) / pi * 2 ;   % theta[0,1] for [0,pi/2]
    
    hr = sqrt(kgray.^2 + color .^2) ;
    
    
return

function [kgray, color, phase] = color_phase(r, g, b, theta) ;

    n1 = max(max(max(r, g), b)) ;
    n3 = min(min(min(r, g), b)) ;
    n2 = r + g + b - n1 - n3 ;

    kgray = n3 / 256 ;
    color = n1 - n3 ;

    if(n1 == r && n2 == g) mode = 1 ; c2 = n2 - n3 ; c1 = color ; end
    if(n1 == g && n2 == r) mode = 1 ; c2 = n1 ; c1 = n2 - n3; end

    if(n1 == g && n2 == b) mode = 5 ; c2 = n2 - n3 ; c1 = color ; end
    if(n1 == b && n2 == g) mode = 5 ; c2 = n1 ; c1 = n2 - n3 ;end

    if(n1 == b && n2 == r) mode = 9 ; c2 = n2 - n3 ; c1 = color ; end
    if(n1 == r && n2 == b) mode = 9 ; c2 = n1 ; c1 = n2 - n3 ;end

    x = 0 ;
    if(c1+c2 > 0) x = c2 / (c1 + c2) * 1/3 + mode / 12 ; end
    x = x + theta ;
    if(x>1) x = x - 1 ; end
    if(x<0) x = x + 1 ; end

    phase = x ;
    color = color / 256 ;

return



