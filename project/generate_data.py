# generate_data.py
import random
import csv
import os

NUM_ROWS = 5000          
DEPARTMENTS = ['Engineering', 'Sales', 'Marketing', 'HR', 'Finance']
NAMES_POOL = ['Alice', 'Bob', 'Charlie', 'Diana', 'Eve', 'Frank', 'Grace', 'Hank', 'Ivy', 'Jack']

output_file = 'data.csv'

with open(output_file, 'w', newline='') as f:
    writer = csv.writer(f)
    for i in range(1, NUM_ROWS + 1):
        name = random.choice(NAMES_POOL) + str(i)
        dept = random.choice(DEPARTMENTS)
        salary = random.randint(30000, 120000)
        writer.writerow([i, name, dept, salary])

print(f"Generated {NUM_ROWS} rows into {output_file}")