clear all ;

ja11 = imread('lena512color.jpg') ;
 
ja41 = single(ja11) ;
[np1, np2, np3] = size(ja41) ;
np1 = floor(np1/4)*4 ;
np2 = floor(np2/4)*4 ;
ja4 = ja41(1:np1, 1:np2, 1:3) ; 

offset = 3/12 ;
 
[y55, k55, angle55] = convert_rgb2polar(ja4, offset) ;

[nn1, nn2] = size(y55) ; % 81 ; % 81 ; % 72 ;
a5  = y55(1:nn1,1:nn2) ;

figure(1),
 imagesc([ja4(:,:,1),ja4(:,:,2),ja4(:,:,3); 255*y55,255*(1-k55),255*angle55]) ;
 colormap('gray') ;
 
% jjimg = round(255 * (1-k55)) ;

jjimg = 1 - k55 ;

n1 = 220 ;
n2 = 210 ;
nstep = 180 ;
ppimg = jjimg(n1:n1+nstep, n2:n2+nstep) ;

figure(2),
imagesc(ppimg) ;
colormap('gray') ;

figure(3),
 imagesc([ppimg, fliplr(ppimg); rot90(ppimg,1), rot90(ppimg,1)'; ppimg', rot90(ppimg',-1); ppimg', fliplr((ppimg')')
     ]) ;
 colormap('gray') ;
