function [x,k] = SOR(A,b,x0,w,tol)
D = diag(diag(A));
L = tril(A,-1);
U = triu(A,1);
L1 = D + w*L;
G1 = ((1-w)*D-w*U);
d = w*b;

k = 0;

while 1
    b = G1*x0 + d;
    x = inv(L1)*b;
    e = norm(x-x0,inf);
    x0 = x;
    if e <= tol
        break;
    end
    
    k = k + 1;
end
end

