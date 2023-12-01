% Define the covariance matrix (given in Table 1, multiplied by 10^-2)
Sigma = [4.01, -1.19, 0.60, 0.74, -0.21; 
         -1.19, 1.12, 0.21, -0.54, 0.55; 
         0.60, 0.21, 3.31, 0.77, 0.29; 
         0.74, -0.54, 0.77, 3.74, -1.04; 
         -0.21, 0.55, 0.29, -1.04, 2.6] * 1e-2;

% Define the matrices A and b for the KKT system
A11 = 2 * Sigma;
A12 = -ones(5, 1);
A21 = ones(1, 5);
A22 = 0;

A = [A11, A12; A21, A22];
b = [zeros(5, 1); 1];

% Solve the KKT system using MATLAB
[x, ~, ~, ~, lambda] = quadprog(A11, [], [], [], A21, 1, zeros(5, 1), []);

% Display the results
disp('Computed weights:');
disp(x);
disp('Variance of corresponding portfolio:');
variance = x' * Sigma * x;
disp(variance);
