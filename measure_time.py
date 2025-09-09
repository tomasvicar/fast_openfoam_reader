from fastops import read_int_groups_from_file
import time

start_time = time.perf_counter()
groups = read_int_groups_from_file("/data/faces")
end_time = time.perf_counter()
print(f"Time taken: {end_time - start_time} seconds")

print(len(groups))