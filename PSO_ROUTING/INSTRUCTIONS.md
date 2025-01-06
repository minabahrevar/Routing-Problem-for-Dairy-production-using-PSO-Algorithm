# Project Instructions

## Overview

This project implements a Particle Swarm Optimization (PSO) algorithm to solve a customer routing problem. The main script (`run.py`) allows users to configure and run the PSO algorithm on a given problem instance.

## Directory Structure

```
PSO_ROUTING/
├── data/
│   └── R101.txt
├── run.py
├── alg_creator.py
├── core_funs.py
├── process_data.py
├── plotting.py
├── utils.py
└── generate_data.py
```

## Setup Instructions

### 1. Create a Virtual Environment

Create and activate a virtual environment to manage dependencies:

```sh
python -m venv venv
source venv/bin/activate
# On Windows use
`venv\Scripts\activate`
```

### 2. Install Dependencies

Install the required Python packages using `pip`:

```sh
pip install -r requirements.txt
```

## Generating Data

### 1. Run the Data Generation Script

There are multiple data files already present at data/ directory, if you want to generate new random ones do this:

To generate a new data file, run the `generate_data.py` script:

```sh
python generate_data.py
```

### 2. Enter the Filename

When prompted, enter the filename to save the dataset, for example:

```
Enter the filename to save the dataset (e.g., 'data/R101.txt'): data/R102.txt
```

### 3. Verify the Generated Data

The generated data file will be saved with the specified filename in the `data` directory. The first line of the file will reflect the base name of the file (e.g., `R102`).

## Running the Project

### 1. Prepare Data

Ensure that your problem instance file (e.g., `R101.txt` or the newly generated file) is placed inside the `data/` directory.

### 2. Run the Script

Execute the main script with the problem instance name as an argument:

```sh
python run.py R101
```

### 3. Configure Parameters

The script will prompt you to enter various PSO parameters. You can accept the default values by pressing Enter or provide your own values.

### 4. View Results

The script will output the progress of the PSO algorithm and display the best found solution along with its fitness and total cost. Plots for the problem instance and the fitness over iterations will be saved in the current directory as `instance_plot.png` and `fitness_over_iterations.png`. The route plot will be saved as `route_plot.png`.

## Code Breakdown

### `run.py`

This is the main entry point. It handles user input and runs the PSO algorithm.

### `alg_creator.py`

Contains the main PSO implementation, including the functions to run the algorithm and print the route.

### `core_funs.py`

Includes core functions for fitness calculation, route creation, and particle manipulation.

### `process_data.py`

Handles loading and processing of problem instance data.

### `plotting.py`

Contains functions for plotting the problem instance, routes, and fitness over iterations.

### `utils.py`

Includes utility functions such as `get_input` for prompting user input with default values.

### `generate_data.py`

Generates a dataset similar to the provided example and saves it to a specified file.
