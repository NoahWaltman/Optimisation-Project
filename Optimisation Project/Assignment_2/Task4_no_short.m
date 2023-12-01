% Define the covariance matrix (given in Table 1, multiplied by 10^-2)
Sigma = [4.01, -1.19, 0.60, 0.74, -0.21; 
         -1.19, 1.12, 0.21, -0.54, 0.55; 
         0.60, 0.21, 3.31, 0.77, 0.29; 
         0.74, -0.54, 0.77, 3.74, -1.04; 
         -0.21, 0.55, 0.29, -1.04, 2.6] * 1e-2;

% Define the expected rates of return (given in Table 1)
expected_returns = [13.0; 4.4; 12.1; 7.1; 11.7] / 100; % converted to decimal

% Define the number of assets
n = length(expected_returns);

% Range of alpha values
alphas = 0.05:0.05:1;

% Initialize arrays to store results
efficient_frontier_returns = zeros(length(alphas), 1);
efficient_frontier_variances = zeros(length(alphas), 1);

% Loop over alpha values
for k = 1:length(alphas)
    alpha = alphas(k);
    
    % Define the matrices Aeq and beq for the equality constraints
    Aeq = ones(1, n);
    beq = 1;
    
    % Initial point (equal allocation to all assets)
    x0 = ones(5, 1) / 5;

    % Define the options for the quadprog function
    options = optimset('Algorithm', 'active-set', 'Display', 'off');

    % Solve the quadratic program using MATLAB with an initial point (allowing short selling)
    w = quadprog(alpha * 2 * Sigma, -(1 - alpha) * expected_returns, [], [], Aeq, beq, zeros(n, 1), [], x0, options);
    
    % Calculate portfolio variance
    portfolio_variance = w' * Sigma * w;

    % Store results
    efficient_frontier_returns(k) = sum(expected_returns' * w);
    efficient_frontier_variances(k) = portfolio_variance;
end

% Plot the efficient frontier
figure;
plot(efficient_frontier_variances, efficient_frontier_returns);
title('Efficient Frontier without short selling');
xlabel('Portfolio Variance');
ylabel('Expected Rate of Return');
grid on;