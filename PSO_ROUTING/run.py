import sys
import random
from alg_creator import run_pso
from utils import get_input

if __name__ == '__main__':

    if len(sys.argv) != 2:
        print("Invalid arguments")
        sys.exit()

    random.seed(231)
    plot_result = True

    problem_name = str(sys.argv[1])
    alg_name = "PSO"

    if alg_name == "PSO":
        # Default values
        default_customers_count = 25
        default_max_generations = 1500
        default_particles_pop_size = 80
        default_cognitive_acceleration = 2.0
        default_social_acceleration = 2.0
        default_speed_limit = 1.5

        # Prompt the user for PSO parameters with default values
        customers_count = get_input("Enter the number of customers", default_customers_count, int)
        max_generations = get_input("Enter the maximum number of iterations", default_max_generations, int)
        particles_pop_size = get_input("Enter the particle population size", default_particles_pop_size, int)
        cognitive_acceleration = get_input("Enter the cognitive acceleration coefficient", default_cognitive_acceleration, float)
        social_acceleration = get_input("Enter the social acceleration coefficient", default_social_acceleration, float)
        speed_limit = get_input("Enter the speed limit", default_speed_limit, float)

        print('### GENERAL INFO ###')
        print('Problem name: ' + problem_name)
        print(f'Customer count: {customers_count}')
        print(f'Max iterations: {max_generations}')
        print('Algorithm: ' + alg_name)
        print('### ALGORITHM PARAMETERS ###')
        print(f'Particles population size: {particles_pop_size}')
        print(f'Social acceleration: {social_acceleration}')
        print(f'Cognitive acceleration: {cognitive_acceleration}')
        print(f'Speed limit: {speed_limit}')

        # Run PSO
        res = run_pso(instance_name=problem_name, particle_size=customers_count, pop_size=particles_pop_size,
                      max_iteration=max_generations, cognitive_coef=cognitive_acceleration,
                      social_coef=social_acceleration, s_limit=speed_limit, plot=plot_result)
    else:
        print("Invalid algorithm")
        sys.exit()
