function [G , d , x , N] = jacobi(A, b)
    
    n = size(A);
    len = size(A,1);
    wid = size(A,2);
    if  len ~= wid
        return;
    end
    
    N = 1;
    B = zeros(n);
    D = zeros(n);
    G = zeros(n);
    
    x = zeros(len,1);
    d = ones(len,1);
    
    B = A;
    
    for i = 1: len
        B(i,i) = 0;
        D(i,i) = A(i,i);
    end
    
    G = -inv(D)*B;
    
    if vrho(G)>1
        error('no');
    end
    
    x1 = x;
    x2 = G*x + d;
    
    while norm(x2 - x1,inf) < 10^(-6)
        x1 = x2;
        x2 = G*x2 + d;
        N = N +1;
    end
    
    x = x2 ; 
end

