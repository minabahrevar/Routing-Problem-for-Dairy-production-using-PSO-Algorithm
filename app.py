# app.py
import pso

# A Sample Cost Function
def Sphere(x):
    return sum(x**2)

# Define Optimization Problem
problem = {
    'CostFunction': Sphere,
    'nVar': 10,
    'VarMin': -5,  # Alternatively you can use a "numpy array" with nVar elements, instead of scalar
    'VarMax': 5,   # Alternatively you can use a "numpy array" with nVar elements, instead of scalar
}

# Running PSO
pso.tic()
print('Running PSO ...')
gbest, pop, best_costs = pso.PSO(problem, MaxIter=200, PopSize=50, c1=1.5, c2=2, w=1, wdamp=0.995)
print()
pso.toc()
print()

# Final Result
print('Global Best:')
print(gbest)
print()

# Plot the best cost values
pso.plot_best_costs(best_costs)

## app.py: This is just a comment indicating the name of the Python file.

import pso: This line imports the pso module, which likely contains the implementation of the Particle Swarm Optimization (PSO) algorithm.

# A Sample Cost Function, def Sphere(x):: This defines a simple cost function called Sphere that takes an input vector x and returns the sum of the squares of its elements. This is a common benchmark function used to test optimization algorithms.

# Define Optimization Problem, problem = {...}: This block defines a dictionary called problem that contains the details of the optimization problem. It includes:

#'CostFunction': Sphere: The cost function to be minimized, which is the Sphere function defined earlier.
#'nVar': 10: The number of variables (dimensions) in the optimization problem, which is set to 10.
#'VarMin': -5: The minimum value for each variable, which is set to -5.
#'VarMax': 5: The maximum value for each variable, which is set to 5.
# Running PSO, pso.tic(): This starts a timer to measure the runtime of the PSO algorithm.

#print('Running PSO ...'): This prints a message indicating that the PSO algorithm is running.

#gbest, pop, best_costs = pso.PSO(problem, MaxIter=200, PopSize=50, c1=1.5, c2=2, w=1, wdamp=0.995): This is the core of the code, where the PSO algorithm is executed. The pso.PSO() function takes the problem definition and various parameters, and returns:

#gbest: The global best solution found by the algorithm.
#pop: The final population of particles.
#best_costs: The best cost values found at each iteration.
#The parameters passed to pso.PSO() are:
#MaxIter=200: The maximum number of iterations for the algorithm (200 in this case).
#PopSize=50: The population size (number of particles) used in the algorithm (50 in this case).
#c1=1.5, c2=2, w=1, wdamp=0.995: These are parameters that control the behavior of the PSO algorithm.
#pso.toc(): This stops the timer and prints the elapsed time.

# Final Result, print('Global Best:'), print(gbest): This block prints the global best solution found by the PSO algorithm.

# Plot the best cost values, pso.plot_best_costs(best_costs): This line calls a function to plot the best cost values found at each iteration of the PSO algorithm.

#In summary, this code demonstrates the use of the PSO algorithm to optimize a simple benchmark function (the Sphere function). The problem definition, algorithm parameters, and visualization of the results are all handled within the code.
