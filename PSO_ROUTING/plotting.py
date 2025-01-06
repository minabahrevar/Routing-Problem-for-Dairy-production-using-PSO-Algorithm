# plotting.py
import matplotlib.pyplot as plt
from process_data import load_problem_instance, COORDINATES, X_COORD, Y_COORD, DEPART

def plot_instance(instance_name, customer_number, save_path="instance_plot.png"):
    instance = load_problem_instance(instance_name)
    depot = [instance[DEPART][COORDINATES][X_COORD], instance[DEPART][COORDINATES][Y_COORD]]
    dep, = plt.plot(depot[0], depot[1], 'kP', label='depot')

    for customer_id in range(1, customer_number):
        coordinates = [instance[F'C_{customer_id}'][COORDINATES][X_COORD],
                       instance[F'C_{customer_id}'][COORDINATES][Y_COORD]]
        custs, = plt.plot(coordinates[0], coordinates[1], 'ro', label='customers')
    plt.ylabel("y coordinate")
    plt.xlabel("x coordinate")
    plt.title('instances')
    plt.legend([dep, custs], ['depot', 'customers'], loc=1)
    plt.savefig(save_path)
    plt.close()

def plot_route(route, instance_name, save_path="route_plot.png"):
    instance = load_problem_instance(instance_name)
    color_pack = ['bo', 'go', 'ro', 'co', 'mo', 'yo', 'ko',
                  'b*', 'g*', 'r*', 'c*', 'm*', 'y*', 'k*',
                  'bp', 'gp', 'rp', 'cp', 'mp', 'yp', 'kp']
    line_color_pack = ['b', 'g', 'r', 'c', 'm', 'y', 'k',
                       'b', 'g', 'r', 'c', 'm', 'y', 'k']
    c_ind = -1

    depot = [instance[DEPART][COORDINATES][X_COORD], instance[DEPART][COORDINATES][Y_COORD]]
    plt.plot(depot[0], depot[1], 'kP')
    for single_route in route:
        c_ind += 1
        coordinates = depot
        for customer_id in single_route:
            prev_coords = coordinates
            coordinates = [instance[F'C_{customer_id}'][COORDINATES][X_COORD],
                           instance[F'C_{customer_id}'][COORDINATES][Y_COORD]]
            plt.plot(coordinates[0], coordinates[1], color_pack[c_ind])
            plt.arrow(prev_coords[0], prev_coords[1], coordinates[0] - prev_coords[0],
                      coordinates[1] - prev_coords[1], color=line_color_pack[c_ind],
                      length_includes_head=True, head_width=1, head_length=2)
        plt.arrow(coordinates[0], coordinates[1], depot[0] - coordinates[0],
                  depot[1] - coordinates[1], color=line_color_pack[c_ind],
                  length_includes_head=True, head_width=1, head_length=2)
    plt.ylabel("y coordinate")
    plt.xlabel("x coordinate")
    plt.title('Possible Routes')
    plt.savefig(save_path)
    plt.close()

def save_fitness_plot(fitness_over_time, save_path="fitness_over_iterations.png"):
    plt.plot(fitness_over_time)
    plt.xlabel('Iteration')
    plt.ylabel('Fitness')
    plt.title('Fitness over Iterations')
    plt.savefig(save_path)
    plt.close()
