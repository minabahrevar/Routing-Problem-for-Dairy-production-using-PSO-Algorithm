import random
import os

def generate_data(file_name, num_customers=100, vehicle_capacity=200, max_x=70, max_y=70, max_demand=50,
                  max_ready_time=200, max_due_time=230, max_service_time=20):
    """
    Generates a dataset similar to the provided example and saves it to a file.
    
    Parameters:
        file_name (str): Name of the file to save the dataset.
        num_customers (int): Number of customers (excluding the depot).
        vehicle_capacity (int): Capacity of the vehicle.
        max_x (int): Maximum x-coordinate.
        max_y (int): Maximum y-coordinate.
        max_demand (int): Maximum demand of a customer.
        max_ready_time (int): Maximum ready time.
        max_due_time (int): Maximum due date.
        max_service_time (int): Maximum service time.
    """
    base_name = os.path.splitext(os.path.basename(file_name))[0]
    
    with open(file_name, 'w') as file:
        file.write(f"{base_name}\n\n")
        file.write("VEHICLE\n")
        file.write("NUMBER     CAPACITY\n")
        file.write(f"  {25:<9} {vehicle_capacity}\n\n")
        file.write("CUSTOMER\n")
        file.write("CUST NO.   XCOORD.   YCOORD.    DEMAND   READY TIME   DUE DATE   SERVICE TIME\n")
        file.write(" \n")
        
        # Depot entry
        file.write(f"    0          {35:<2}      {35:<2}           0       0         {max_due_time:<3}           0\n")
        
        # Customer entries
        for i in range(1, num_customers + 1):
            x_coord = random.randint(0, max_x)
            y_coord = random.randint(0, max_y)
            demand = random.randint(1, max_demand)
            ready_time = random.randint(0, max_ready_time)
            due_date = random.randint(ready_time + 10, max_due_time)  # Ensure due_date is after ready_time
            service_time = random.randint(1, max_service_time)
            
            file.write(f"    {i:<2}         {x_coord:<2}      {y_coord:<2}          {demand:<2}     {ready_time:<3}         {due_date:<3}          {service_time:<2}\n")

if __name__ == "__main__":
    file_name = input("Enter the filename to save the dataset (e.g., 'data/R101.txt'): ")
    os.makedirs(os.path.dirname(file_name), exist_ok=True)
    generate_data(file_name)
