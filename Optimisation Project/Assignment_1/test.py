from cirpdf import cirpdf
import numpy as np
from scipy.stats import norm
from scipy.optimize import minimize
import pandas as pd

# Load the provided data from a CSV file
data = pd.read_csv("CIRDataSet.csv")  

data = data[['t', 'data']].to_numpy()

# Define the log-likelihood function
def log_likelihood(params, data):
    a, b, sigma = params
    log_likelihood_sum = 0.0

    for i in range(1, len(data)):
        dt = data[i, 0] - data[i - 1, 0]
        xi_minus_1 = data[i - 1, 1]
        xi = data[i, 1]
        log_likelihood_sum += np.log(cirpdf(np.array([xi_minus_1, xi]), np.array([data[i - 1, 0], data[i, 0]]), a, b, sigma).sum())

    return -log_likelihood_sum  # Negate for minimization


initial_guess = [0.1, 0.1, 0.1]

# Perform optimization
result = minimize(log_likelihood, initial_guess, args=(data,), method='L-BFGS-B')

# Extract the optimal parameters
optimal_params = result.x
a_opt, b_opt, sigma_opt = optimal_params

print(f"Optimal Parameters from initial guess: {initial_guess}")
print("a =", a_opt)
print("b =", b_opt)
print("sigma =", sigma_opt)


