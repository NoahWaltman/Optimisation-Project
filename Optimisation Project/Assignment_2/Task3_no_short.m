% Define the covariance matrix (given in Table 1, multiplied by 10^-2)
Sigma = [4.01, -1.19, 0.60, 0.74, -0.21; 
         -1.19, 1.12, 0.21, -0.54, 0.55; 
         0.60, 0.21, 3.31, 0.77, 0.29; 
         0.74, -0.54, 0.77, 3.74, -1.04; 
         -0.21, 0.55, 0.29, -1.04, 2.6] * 1e-2;

% Define the expected rates of return (given in Table 1)
expected_returns = [13.0; 4.4; 12.1; 7.1; 11.7] / 100; % converted to decimal

% Define the target expected rate of return
rho = 0.2;

% Define the matrices Aeq and beq for the equality constraints
Aeq = [ones(1, 5); expected_returns'];
beq = [1; rho];

% Initial point (equal allocation to all assets)
x0 = ones(5, 1) / 5;

% Define the options for the quadprog function
options = optimset('Algorithm', 'active-set', 'Display', 'on');

% Solve the quadratic program using MATLAB with an initial point (no short selling)
w = quadprog(2 * Sigma, [], [], [], Aeq, beq, zeros(5, 1), [], x0, options);

% Display the results
disp('Computed weights (no short-selling):');
disp(w');
disp('Variance of corresponding portfolio:');
variance = w' * Sigma * w;
disp(variance);

