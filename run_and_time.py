import time
import subprocess
import sys

# Check if program name is passed
if len(sys.argv) < 2:
    print("Please provide the path to the program to run.")
    print("Usage: python run_and_time.py path_to_program")
    sys.exit(1)

program_path = sys.argv[1]

# Print the command to be executed
print(f"Command to run: {program_path}")

# Start timer
start_time = time.perf_counter()

# Run the program
try:
    subprocess.run(program_path, shell=True, check=True)
except subprocess.CalledProcessError as e:
    print("Error running program:", e)
    sys.exit(1)

# End timer
end_time = time.perf_counter()

# Calculate duration in milliseconds
duration_ms = (end_time - start_time) * 1000

print(f"Execution time: {duration_ms:.3f} milliseconds")
