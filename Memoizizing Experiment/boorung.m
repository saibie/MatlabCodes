mfoo = memoize(@foo); 
tic;foo(4),toc
tic;foo(4),toc
tic;mfoo(4),toc
tic;mfoo(4),toc