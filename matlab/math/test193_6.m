A1 = [8.3 2.1 -1.2 0.5; 
      0.8 10.2 3.5 -1.8; 
      1.2 0.2 -4 -0.5; 
      -0.2 0.3 0.4 -2];
b1 = [-3.02 4.79 -6.72 8.89];

[G , d , x , N] = jacobi(A1,b1)
[x , N] = gaussSeidel(A1,b1)