from core_funs import *
from deap import base, creator, tools
import numpy
import time
from tabulate import tabulate
from process_data import load_problem_instance
from plotting import plot_instance, plot_route, save_fitness_plot

def print_route(route):
    route_num = 0
    for sub_route in route:
        route_num += 1
        single_route = '0'
        for customer_id in sub_route:
            single_route = f'{single_route} -> {customer_id}'
        single_route = f'{single_route} -> 0'
        print(f' # Route {route_num} # {single_route}')

def run_pso(instance_name, particle_size, pop_size, max_iteration,
            cognitive_coef, social_coef, s_limit=3, plot=False, save=False, logs=False):

    instance = load_problem_instance(instance_name)

    if instance is None:
        return

    if plot:
        plot_instance(instance_name=instance_name, customer_number=particle_size, save_path="instance_plot.png")

    creator.create("FitnessMax", base.Fitness, weights=(1.0, 1.0))
    creator.create("Particle", list, fitness=creator.FitnessMax, speed=list,
                   smin=None, smax=None, best=None)

    toolbox = base.Toolbox()
    toolbox.register("particle", generate_particle,
                     size=particle_size, val_min=1, val_max=particle_size, s_min=-s_limit, s_max=s_limit)
    toolbox.register("population", tools.initRepeat, list, toolbox.particle)
    toolbox.register("update", update_particle, phi1=cognitive_coef, phi2=social_coef)
    toolbox.register('evaluate', calculate_fitness, data=instance)

    pop = toolbox.population(n=pop_size)
    stats = tools.Statistics(lambda ind: ind.fitness.values)
    stats.register("avg", numpy.mean)
    stats.register("std", numpy.std)
    stats.register("min", numpy.min)
    stats.register("max", numpy.max)

    logbook = tools.Logbook()
    logbook.header = ["gen", "evals"] + stats.fields

    best = None
    iter_num = 0
    previous_best = 0

    fitness_over_time = []  # List to store the best fitness at each iteration
    table_data = []  # List to store data for the table

    print('### START ###')
    start = time.time()

    for g in range(max_iteration):

        fit_count = 0
        for part in pop:
            part.fitness.values = toolbox.evaluate(part)
            if part.fitness.values[0] > previous_best:
                previous_best = part.fitness.values[0]
                iter_num = g + 1
            elif part.fitness.values[0] == previous_best:
                fit_count += 1

        if fit_count > int(numpy.ceil(pop_size * 0.15)):
            rand_pop = toolbox.population(n=pop_size)
            for part in rand_pop:
                part.fitness.values = toolbox.evaluate(part)
            some_inds = tools.selRandom(rand_pop, int(numpy.ceil(pop_size * 0.1)))  # random pop here
            mod_pop = tools.selWorst(pop, int(numpy.ceil(pop_size * 0.9)))
        else:
            some_inds = tools.selBest(pop, int(numpy.ceil(pop_size * 0.05)))  # elite pop here
            mod_pop = tools.selRandom(pop, int(numpy.ceil(pop_size * 0.95)))

        mod_pop = list(map(toolbox.clone, mod_pop))

        for part in mod_pop:
            if not part.best or part.best.fitness < part.fitness:
                part.best = creator.Particle(part)
                part.best.fitness.values = part.fitness.values
            if not best or best.fitness < part.fitness:
                best = creator.Particle(part)
                best.fitness.values = part.fitness.values

        for part in mod_pop:
            toolbox.update(part, best)

        mod_pop.extend(some_inds)
        pop[:] = mod_pop

        # Gather all the stats in one list and print them
        logbook.record(gen=g+1, evals=len(pop), **stats.compile(pop))
        print(logbook.stream)

        # Store the best fitness value for plotting and table
        best_fitness = max([ind.fitness.values[0] for ind in pop])
        fitness_over_time.append(best_fitness)

        # Collect data for the table
        avg_fitness = numpy.mean([ind.fitness.values[0] for ind in pop])
        min_fitness = min([ind.fitness.values[0] for ind in pop])
        max_fitness = max([ind.fitness.values[0] for ind in pop])
        std_dev_fitness = numpy.std([ind.fitness.values[0] for ind in pop])
        table_data.append([g + 1, avg_fitness, min_fitness, max_fitness, std_dev_fitness])

    end = time.time()
    print('### FINAL OUTPUT ###')
    best_ind = tools.selBest(pop, 1)[0]
    print(f'Best individual: {best_ind}')
    route = create_route_from_ind(best_ind, instance)
    print_route(route)
    print(f'Fitness: { round(best_ind.fitness.values[0],2) }')
    print(f'Found in Iteration Number: { iter_num }')
    print(f'Total cost: { round(calculate_fitness(best_ind, instance)[1],2) }')
    print(f'Execution time (s): { round(end - start,2) }')

    # Save fitness over iterations plot
    save_fitness_plot(fitness_over_time)

    # Plot and save the route
    if plot:
        plot_route(route, instance_name, save_path="route_plot.png")
