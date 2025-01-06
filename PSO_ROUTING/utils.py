# utils.py

def get_input(prompt, default, type_cast):
    """
    Helper function to get user input with a default value.
    """
    user_input = input(f"{prompt} (default: {default}): ")
    if user_input == "":
        return default
    try:
        return type_cast(user_input)
    except ValueError:
        print(f"Invalid input. Using default value: {default}")
        return default
